require 'rails_helper'

RSpec.feature "Visitor navigates to a product details page from the home page", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path
    puts page.html

    find("a[href='/products/10']", match: :first).click

    # DEBUG / VERIFY
    expect(page).to have_css '.products-show'
    save_screenshot

  end

end

