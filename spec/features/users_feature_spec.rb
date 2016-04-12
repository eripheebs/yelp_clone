require 'rails_helper'

feature 'User can sign in and out' do
  context 'User not signed in and on homepage' do
    it 'should see a sign-in and a sign-up link' do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it 'should not see a sign-out link' do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end
  end

  context 'User signed in and on homepage' do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: 'misa@misa.com'
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '123456789'
      click_button 'Sign up'
    end

    it 'should see a sign-out link' do
      visit '/'
      expect(page).to have_link('Sign out')
    end

    it 'should not see a sign-in and a sign-up link' do
      visit '/'
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
  end
end