require 'rails_helper'

describe 'the sign-in process for users who are not signed in' do
  before :each do
    visit new_user_session_path
    User.create(
      email: 'user@example.com',
      password: 'password',
      other_residents: 2
    )
  end

  after :each do
    user = User.find_by email: 'user@example.com'
    user.destroy
  end

  it 'displays a sign in page' do
    expect(page).to have_content('Log in')
  end

  it 'links to the sign up page' do
    click_on 'Sign up'
    expect(page).to have_content('Sign up')
  end

  it 'takes user to rankings#index after signing in' do
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Your rankings')
  end
end

describe 'the sign-up process' do
  before :each do
    visit new_user_registration_path
  end
  it 'asks for an email address' do
    expect(page).to have_content('Email')
  end

  it 'asks for a password' do
    expect(page).to have_content('Password')
  end

  it 'asks for the number of other residents' do
    expect(page).to have_content('How many other people will be living with you?')
  end

  it 'takes user to rankings#index after signing up' do
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'How many other people will be living with you?', with: '2'
    click_button 'Sign up'
    expect(page).to have_content('Your rankings')
  end
end
