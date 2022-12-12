require 'rails_helper'

RSpec.describe User, type: :model do
  first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  second_user = User.create(name: nil, photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Nigeria.')

  describe 'Validations: ' do
    context 'Name validations:' do
      it 'User with name should be valid' do
        first_user.save
        expect(first_user).to be_valid
      end

      it 'User without name should be invalid' do
        second_user.save
        expect(second_user).to_not be_valid
      end
    end

    context 'Counter validations:' do
      it 'users should have integer values for post_counter ' do
        first_user.posts_counter = 2
        first_user.save
        expect(first_user).to be_valid
      end

      it 'Users without inter values for post_counter should not be valid' do
        first_user.posts_counter = 'one'
        first_user.save
        expect(first_user).to_not be_valid
      end
    end
  end

  describe 'Tests for methods' do
    context 'Methods of User:' do
      it '#recent_posts method should return zero(0) when new user is created' do
        new_user = User.create(name: 'Killy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'developer from Ghana.')
        expect(new_user.recent_posts.count).to eq 0
      end

      it '#recent_posts method should return most recent three(3) posts of user' do
        Post.create(author: first_user, title: 'How to be a good Dev',
                    text: 'This is the top three ways to be great dev')
        Post.create(author: first_user, title: 'Why sleep is important',
                    text: 'This is the top three reasons why sleep is important')
        expect(first_user.recent_posts.count).to eq 2
      end
    end
  end
end
