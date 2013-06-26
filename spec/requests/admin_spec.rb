require 'spec_helper'

describe 'Admin' do
  context "on admin homepage" do

    before(:each) do
      @post = Post.new 
      @post.title = "Abi ain't my Daddy"
      @post.content = "Having it"
      @post.is_published = true
      @post.save
      page.driver.browser.basic_authorize('geek', 'jock')
    end

    it "can see a list of recent posts" do
      visit admin_posts_url
      page.should have_content(@post.title)
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_url
      click_link 'Edit'
      expect(page).to have_content "Publish?"
      expect(page).to have_content @post.title
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_url
      expect(page).to have_content @post.title
      click_link 'Delete'
      expect(page).to have_no_content @post.title
    end

    it "can create a new post and view it" do
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      visit admin_posts_url
      p page.html
      click_link 'Edit'
      uncheck('is_published')
      click_button 'Save'

      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title"
    it "can see an edit link that takes you to the edit post path"
    it "change go to the admin homepage by clicking the Admin welcome page link"
  end
end
