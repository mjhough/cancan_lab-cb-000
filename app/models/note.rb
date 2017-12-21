class Note < ActiveRecord::Base
  belongs_to :user
  has_many :viewers
  has_many :readers, through: :viewers, source: :user

  before_save :ensure_owner_can_read

  def visible_to=(names)
    array_of_names = names.split(', ')
    self.readers = array_of_names.collect do |name|
      User.find_by(name: name.strip)
    end
  end

  def visible_to
    readers.collect { |reader| reader.name }.join(', ')
  end

  private

  def ensure_owner_can_read
    if user && !readers.include?(user)
      readers << user
    end
  end

end