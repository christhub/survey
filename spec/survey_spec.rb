require 'spec_helper'

describe(Survey) do
  it('uppercases the titles') do
    survey = Survey.create({title: 'meXican FooD'})
    expect(survey.title).to(eq('MEXICAN FOOD'))
  end
end
