class Survey < ActiveRecord::Base
  belongs_to(:list)
  validates(:title, {presence: true})
  before_save(:upcase_title)

private

  def upcase_title
    self.title=(title.upcase)
  end
end
