require 'spec_helper'

describe Post do

  let(:my_title) { "my post" }
  let(:my_post) do
    my_post = Post.new
    my_post.title = my_title
    my_post.content = "Jamming on it hard"
    my_post.save
    my_post
  end

  it "title should be automatically titleized before save" do
    expect(my_post.title).to eq 'My Post'
  end

  it "post should be unpublished by default" do
    expect(my_post.is_published).to eq false
  end

  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    post.slug.should be_nil
    post.save

    post.slug.should eq "new-post"
  end
end
