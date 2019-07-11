# Cheese Shop


### Overview
This app is a shop for cheese. You can see all cheeses, add them to your cart, and checkout if you are a registered user. 'Checking Out' creates an 'Order' that you can then see on your profile page.
- Types of users
  - Buyer
  - Merchant
  - Admin

![welcome_page](/app/assets/images/welcome_page.png)

![welcome_page](/app/assets/images/items_page.png)

A Merchant can add their items which include a price for that item, an inventory amount, and a picture. They can disable, enable, and delete their items as they please. Any item that a merchant makes and that is enabled will show on the main 'cheeses' page for buyers to view. As each of a merchants items are ordered, the merchant can then 'fulfill' all of their items on an order. Once all items on an order are fulfilled, an order's status will change from 'pending' to 'packaged'. Only an admin can change an order's status from 'packaged' to 'shipped'. Once the order is shipped, all of it's items are considered to be sold, and are subtracted from it's inventory.


![welcome_page](/app/assets/images/cart_page.png)

Statistics for Merchants and Items on the site are visible on their respectable pages, and only show statistics for items that have been sold.



#### Versions
- Ruby: 2.4.1
- Rails: 5.1.7

#### Configuration
- clone repo
```ruby
bundle install
rails db:{create,migrate,seed}
rails server
```
- In Browser `localhost:3000`

#### Testing
```ruby
rspec
```
- Rspec/Capybara
- Shoulda Matchers

#### Contributors
- Brennan Ayers
- Billy Homer
- Zach Leach
- Vince Carollo

