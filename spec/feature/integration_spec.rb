# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with: 'the communist manifesto'
    fill_in 'Author', with: 'Karl Marx'
    fill_in 'Price', with: '0'
    fill_in 'Published', with: '1848-02-21'
    click_on 'Create Book'
    expect(page).to have_content('the communist manifesto')
  end

  scenario 'insufficient inputs' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    click_on 'Create Book'
    expect(page).to have_content('error')
    fill_in 'Author', with: 'potter, harry'
    click_on 'Create Book'
    expect(page).to have_content('error')
    fill_in 'Published', with: '2000-01-01'
    click_on 'Create Book'
    expect(page).to have_content('error')
    fill_in 'Price', with: '30.10'
    click_on 'Create Book'
    expect(page).to_not have_content('error')
    expect(page).to have_content('harry potter')
  end

  scenario 'invalid author' do
    visit new_book_path
    fill_in 'Title', with: 'the communist manifesto'
    fill_in 'Author', with: ''
    fill_in 'Price', with: '0'
    fill_in 'Published', with: '1848-02-21'
    click_on 'Create Book'
    expect(page).to have_content('error')
  end

  scenario 'invalid price, out of range' do
    visit new_book_path
    fill_in 'Title', with: 'the communist manifesto'
    fill_in 'Author', with: 'Karl Marx'
    fill_in 'Price', with: '-1.99'
    fill_in 'Published', with: '1848-02-21'
    click_on 'Create Book'
    expect(page).to have_content('error')

    fill_in 'Price', with: '12345678901234567890.12'
    click_on 'Create Book'
    expect(page).to have_content('error')
  end

  scenario 'invalid price, non-numeric' do
    visit new_book_path
    fill_in 'Title', with: 'the communist manifesto'
    fill_in 'Author', with: 'Karl Marx'
    fill_in 'Price', with: 'free!'
    fill_in 'Published', with: '1848-02-21'
    click_on 'Create Book'
    expect(page).to have_content('error')
  end

  scenario 'invalid date' do
    visit new_book_path
    fill_in 'Title', with: 'the communist manifesto'
    fill_in 'Author', with: 'Karl Marx'
    fill_in 'Price', with: '0'
    fill_in 'Published', with: 'way back then'
    click_on 'Create Book'
    expect(page).to have_content('error')
  end

  scenario 'invalid author' do
    visit new_book_path
    fill_in 'Title', with: ''
    fill_in 'Author', with: 'Karl Marx'
    fill_in 'Price', with: '0'
    fill_in 'Published', with: '1848-02-21'
    click_on 'Create Book'
    expect(page).to have_content('error')
  end
end

RSpec.describe 'Creating, editing, and then deleting a book', type: :feature do
  scenario 'create, edit, delete' do
    visit books_path
    expect(page).to have_content('Title')
    click_on 'New Book'
    fill_in 'Title', with: 'About Me'
    fill_in 'Author', with: 'Moi'
    fill_in 'Price', with: '50.04'
    fill_in 'Published', with: '2021-12-21'
    click_on 'Create Book'
    expect(page).to have_content('Book was successfully created.')
    expect(page).to have_content('About Me')
    click_on 'Edit'
    fill_in 'Title', with: 'About Moi'
    click_on 'Update Book'
    expect(page).to have_content('Book was successfully updated.')
    expect(page).to have_content('About Moi')
    click_on 'Show'
    expect(page).to have_content('About Moi')
    expect(page).to have_content('50.04')
    expect(page).to have_content('2021')
    click_on 'Back'
    click_on 'Destroy'
    expect(page).to have_content('Are you sure')
    click_on 'Delete Book'
    expect(page).to have_content('Book was successfully destroyed.')
    expect(page).to_not have_content('About Moi')



  end
end

