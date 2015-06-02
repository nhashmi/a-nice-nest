require 'rails_helper'

describe 'viewing the rankings index' do
  before do
    visit new_user_session_path
    @user = User.create(
      email: 'user@example.com',
      password: 'password',
      other_residents: 2
    )
    @total_residents = @user.other_residents + 1
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  it 'displays the names of each of the residents in the house' do
    names = page.all('.residents li')
    expect(names.length).to eql(@total_residents)
  end

  it 'links to the edit ranking page for each resident' do
    ranking_links = page.all('.residents li a')
    expect(ranking_links.length).to eql(@total_residents)
  end

  it 'indicates which rankings have not yet been completed' do
    expect(page).to have_content('incomplete')
  end

  it 'displays a link to delete a ranking' do
    ranking_links = page.all('')
  end

  it 'links to the candidates#index'

  it 'displays a link to search for a new address'

end

