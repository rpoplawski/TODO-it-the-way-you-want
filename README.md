This folder structure should be suitable for starting a project that uses a database:

* Fork this repo
* Clone this repo
* Run `bundle install` to install `active_record`
* `rake generate:migration <NAME>` to create a migration (Don't include the `<` `>` in your name, it should also start with a capital)
* `rake db:migrate` to run the migration and update the database
* Create models in lib that subclass `ActiveRecord::Base`
* ... ?
* Profit


## Rundown

```
.
├── Gemfile             # Details which gems are required by the project
├── README.md           # This file
├── Rakefile            # Defines `rake generate:migration` and `db:migrate`
├── config
│   └── database.yml    # Defines the database config (e.g. name of file)
├── console.rb          # `ruby console.rb` starts `pry` with models loaded
├── db
│   ├── dev.sqlite3     # Default location of the database file
│   ├── migrate         # Folder containing generated migrations
│   └── setup.rb        # `require`ing this file sets up the db connection
└── lib                 # Your ruby code (models, etc.) should go here
    └── all.rb          # Require this file to auto-require _all_ `.rb` files in `lib`
```

1)How many users are there?
[1] pry(main)> User.count
=> 50

2)What are the 5 most expensive items?
[2] pry(main)> Item.order(price: :DESC).limit(5)
=> [#<Item:0x007fd53ca017e8
  id: 25,
  title: "Small Cotton Gloves",
  category: "Automotive, Shoes & Beauty",
  description: "Multi-layered modular service-desk",
  price: 9984>,
 #<Item:0x007fd53ca01630
  id: 83,
  title: "Small Wooden Computer",
  category: "Health",
  description: "Re-engineered fault-tolerant adapter",
  price: 9859>,
 #<Item:0x007fd53ca01478
  id: 100,
  title: "Awesome Granite Pants",
  category: "Toys & Books",
  description: "Upgradable 24/7 access",
  price: 9790>,
 #<Item:0x007fd53ca012e8
  id: 40,
  title: "Sleek Wooden Hat",
  category: "Music & Baby",
  description: "Quality-focused heuristic info-mediaries",
  price: 9390>,
 #<Item:0x007fd53ca01180
  id: 60,
  title: "Ergonomic Steel Car",
  category: "Books & Outdoors",
  description: "Enterprise-wide secondary firmware",
  price: 9341>]


3)What’s the cheapest book?
[3] pry(main)> Item.where("category LIKE ?", "%book%").order(price: :asc).limit(1)
=> [#<Item:0x007fb560839c18
  id: 76,
  title: "Ergonomic Granite Chair",
  category: "Books",
  description: "De-engineered bi-directional portal",
  price: 1496>]


4)Who lives at “6439 Zetta Hills, Willmouth, WY”? Do they have another address?
[1] pry(main)> Address.find_by(street: "6439 Zetta Hills")
=> #<Address:0x007ff244a27428
 id: 43,
 user_id: 40,
 street: "6439 Zetta Hills",
 city: "Willmouth",
 state: "WY",
 zip: 15029>


5)Correct Virginie Mitchell’s address to “New York, NY, 10108”.
[1] pry(main)> User.find_by(first_name: "Virginie")
=> #<User:0x007fb62bc31688
 id: 39,
 first_name: "Virginie",
 last_name: "Mitchell",
 email: "daisy.crist@altenwerthmonahan.biz">

[2] pry(main)> Address.find_by_user_id(39).update(city: "New York", zip: "10108")
=> true
[4] pry(main)> Address.find(42).update(city: "New York", zip: "10108")
=> true
[5] pry(main)> Address.where(user_id: 39)
=> [#<Address:0x007fec1b147d28
  id: 41,
  user_id: 39,
  street: "12263 Jake Crossing",
  city: "New York",
  state: "NY",
  zip: 10108>,
 #<Address:0x007fec1b147918
  id: 42,
  user_id: 39,
  street: "83221 Mafalda Canyon",
  city: "New York",
  state: "WY",
  zip: 10108>]
 
 
The address has been updated.


6)How much would it cost to buy one of each tool?
[1] pry(main)> Item.where("category LIKE ?", "%tool%").sum(:price)
=> 46477


7)How many total items did we sell?
[1] pry(main)> Order.sum(:quantity)
=> 2125


8)How much was spent on books?
[4] pry(main)> Order.joins("LEFT OUTER JOIN items ON items.id = orders.item_id") .where("category LIKE ?", "%book%").sum("price * quantity")
=> 1081352


9)Simulate buying an item by inserting a User for yourself and an Order for that User.
[3] pry(main)> User.create(first_name: "Blow", last_name: "Joe")
=> #<User:0x007faa5b1ac108 id: 51, first_name: "Blow", last_name: "Joe", email: nil>

[7] pry(main)> Order.create(user_id: 51, item_id: 1, quantity: 1, created_at: Time.now)
=> #<Order:0x007faa5b010bf0
 id: 378,
 user_id: 51,
 item_id: 1,
 quantity: 1,
 created_at: 2015-09-09 16:33:23 -0500>
