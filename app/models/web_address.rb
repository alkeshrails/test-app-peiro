class WebAddress < ApplicationRecord
  after_create :generate_short_url #let's check later about after_validation callback use
  after_create :call_site_visit_job

  validates :full_url, uniqueness: true, presence: true

  scope :top_sites, -> { WebAddress.order("visiting_count desc").first(100) }

  def generate_short_url
    i = 0
    begin
      i += 1
      salt = i > 1 ? "#{rand(11..99)}:" : ""
      rand_string = generate_uniq_url(salt)
      if url_available?(rand_string)
        self.short_url = rand_string
        self.save
      else
        raise
      end
    rescue
      retry
    end
  end

  def generate_uniq_url(salt)
    Base64.encode64(salt+full_url).first(4)
  end

  def increase_visiting_counter
    self.visiting_count = (self.visiting_count || 0) + 1
    self.save
  end

  def call_site_visit_job
    byebug
    VisitSiteJob.perform_later(self.id)
  end

  private
  def url_available?(rand_string)
    self.class.find_by(short_url: rand_string).nil?
  end
end
