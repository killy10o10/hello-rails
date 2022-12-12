require 'rails_helper'

RSpec.describe Post, type: :model do
  test_user = User.create(name: 'Toma', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'Developer from Nigeria.')
  test_user.save
  first_post = Post.create(author: test_user, title: 'Hello Naija', text: 'This is my first post')
  second_post = Post.create(author: test_user, title: nil, text: 'This is my second post')
  describe 'Validations:' do
    context 'Title validations:' do
      it 'should validate that title entered is valid' do
        first_post.save
        expect(first_post).to be_valid
      end

      it 'should should be invalid if title is nil' do
        second_post.save
        expect(second_post).to_not be_valid
      end

      it 'should should flag invalid if title length is above 250' do
        second_post.title = Array.new(10, 'AaBbCcDdEeFfghijklmnopqrstuvwxyz').join
        second_post.save
        expect(second_post).to_not be_valid
      end
    end

    context 'comments_counter validations:' do
      it 'should check for integer values for comments_counter' do
        first_post.save
        expect(first_post).to be_valid
      end

      it 'Posts with integer values for comments_counter should be valid' do
        first_post.save
        expect(first_post.comments_counter).to eq 0
      end

      it 'Posts with comments_counter values less than zero(0) should be invalid ' do
        second_post.comments_counter = -3
        second_post.save
        expect(second_post).to_not be_valid
      end
    end

    context 'likes_counter validations: ' do
      it 'should check for integer values for likes_counter' do
        first_post.save
        expect(first_post).to be_valid
      end

      it 'Likes with likes_counter values less than zero(0) should be invalid' do
        first_post.save
        expect(first_post.likes_counter).to eq 0
      end

      it 'Likes with likes_counter values less than zero(0) should be invalid ' do
        second_post.likes_counter = -1
        second_post.save
        expect(second_post).to_not be_valid
      end
    end
  end

  describe 'Method Tests' do
    context 'Methods of Post:' do
      it '#update_posts_counter should be zero on first initialization of User' do
        new_test_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                    bio: 'Teacher from Mexico.')
        new_test_user.save
        expect(new_test_user.posts_counter).to eq 0
      end

      it '#update_posts_counter should reflect the number of entries saved' do
        expect(test_user.posts_counter).to eq 1
      end

      it '#recent_comments should be zero(0) when a new post is created ' do
        expect(first_post.recent_comments.count).to eq 0
      end

      it '#recent_comments method should return current five(5) comments on post' do
        Comment.create(post: first_post, author: test_user, text: 'Hi Tom!')
        Comment.create(post: first_post, author: test_user, text: 'What an interesting topic')
        Comment.create(post: first_post, author: test_user, text: 'I love cats as pet')
        Comment.create(post: first_post, author: test_user, text: 'Liverpool FC is the best')
        Comment.create(post: first_post, author: test_user, text: 'The USA is evil')
        Comment.create(post: first_post, author: test_user, text: 'Ruby on Rails is cool')
        Comment.create(post: first_post, author: test_user, text: 'I am an atheist')
        expect(first_post.recent_comments.count).to eq 5
      end
    end
  end
end
