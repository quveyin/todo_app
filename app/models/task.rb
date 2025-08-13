class Task < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :recent, -> { order(created_at: :desc) }

  def status
    completed? ? 'Tamamlandı' : 'Bekliyor'
  end

  def toggle_completion!
    update!(completed: !completed)
  end
end