class Survey < ActiveRecord::Base
  has_many(:questions)
  validates(:title, {presence: true})
  before_save(:upcase_title)

private

  def upcase_title
    self.title=(title.upcase)
  end

end
