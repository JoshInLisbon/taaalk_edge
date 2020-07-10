# require 'test_helper'
require File.dirname(__FILE__) + '/../test_helper'

describe TlkPolicy do
  subject { described_class }

  it 'should assign a user to a tlk' do
    @user = FactoryBot.build :user
    @other_user = FactoryBot.build :user
    @tlk = FactoryBot.build :tlk
    @tlk.user = @user
    expect(@tlk.user).to be_present
  end



  # permissions :update? do
  #   it "denies update if Tlk does not belong to user" do
  #     expect(subject).not_to permit(User.new, Post.new(published: true))
  #   end
  # end
end
