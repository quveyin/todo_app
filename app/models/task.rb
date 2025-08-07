class Task < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { minimum: 1, maximum: 255 }
  validates :completed, inclusion: { in: [true, false] }, allow_nil: true
  
  before_validation :set_default_completed

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :recent, -> { order(created_at: :desc) }

  def status
    completed? ? 'Tamamlandı' : 'Bekliyor'
  end

  def toggle_completion!
    update!(completed: !completed)
  end
  
  private
  
  def set_default_completed
    self.completed = false if completed.nil?
  end
end