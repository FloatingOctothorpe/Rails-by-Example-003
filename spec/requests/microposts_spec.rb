require 'spec_helper'

describe "Microposts" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "Creation" do

    describe "failure" do

      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end
    end

    describe "success" do

      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end

      it "should show the right number of microposts and pluralise correctly" do
        ['1 micropost', '2 microposts', '3 microposts'].each do |expected_text|
          visit root_path
          fill_in :micropost_content, :with => "A post"
          click_button
          response.should render_template('pages/home')
          response.should have_selector("span.microposts", :content => expected_text)
        end
      end

      it "should have a delete link for the user's post" do
        content = "A new post with a delete button."
        visit root_path
        fill_in :micropost_content, :with => content
        click_button
        response.should have_selector("ol.microposts") do
          have_selector("a", :href => "/users/#{@user.id}")
          have_selector("span.content", :content => content)
          have_selector("a", :content => "delete")
        end
      end

      it "should not have a delete link for other user's post" do
        content = "A new post without a delete button."
        wrong_user = Factory(:user, :email => "wronguser@example.com")
        wrong_post = Factory(:micropost, :user => wrong_user, :content => content)
        visit root_path
        response.should_not have_selector("ol.microposts") do
          have_selector("a", :href => "/users/#{wrong_user.id}")
          have_selector("a", :content => "delete")
        end
      end
    end
  end
end
