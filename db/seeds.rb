# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Order.destroy_all
OrderItem.destroy_all
Item.destroy_all
User.destroy_all

merchant_1 = User.create!(email: "ron@gmail.com", password: "12345", role: 1, active: true, name: "Ron", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
merchant_2 = User.create!(email: "jon@gmail.com", password: "12345", role: 1, active: true, name: "Jon", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
merchant_3 = User.create!(email: "sarahm334@gmail.com", password: "12345", role: 1, active: true, name: "Sarah Mandy", address: "5436 Longstooth drive", city: "Portland", state: "OR", zip: '72722')
merchant_4 = User.create!(email: "phillipe33@gmail.com", password: "12345", role: 1, active: true, name: "Phillipe Hernandez", address: "9292 Very Humid Drive", city: "Houston", state: "TX", zip: '22353')
merchant_5 = User.create!(email: "lareza9@gmail.com", password: "12345", role: 1, active: true, name: "Lareza Samuel", address: "Month Rd", city: "Kalamazoo", state: "MI", zip: '22222')
merchant_6 = User.create!(email: "emilygill@gmail.com", password: "12345", role: 1, active: true, name: "Emily Gill", address: "2352 Moon Light Lane", city: "Chicago", state: "IL", zip: '23636')
merchant_7 = User.create!(email: "papajame@gmail.com", password: "12345", role: 1, active: true, name: "Papa James", address: "1 Lark Hill ln", city: "Cleveland", state: "OH", zip: '38301')
admin_1 = User.create!(email: "admin", password: "12345", role: 2, active: true, name: "Jake", address: "666 End Lane", city: "Kansas City", state: "MO", zip: '63082')

gouda = Item.create!(name: "Gouda", price: 12.99, image: 'https://images-na.ssl-images-amazon.com/images/I/41Y49vVUZnL.jpg', inventory: 265, description: "Gouda is a mild, yellow cheese, originating from the Netherlands, made from cow's milk. It is one of the most popular cheeses worldwide. The name is used today as a general term for numerous similar cheeses produced in the traditional Dutch manner.", user: merchant_1)
brie = Item.create!(name: "Brie", price: 18.99, image: 'https://cdn.shopify.com/s/files/1/2836/2982/products/brie-recipe_grande.jpg?v=1533088694', inventory: 657, description: "Brie is a soft cow's-milk cheese named after Brie, the French region from which it originated. It is pale in color with a slight grayish tinge under a rind of white mould. The rind is typically eaten, with its flavor depending largely upon the ingredients used and its manufacturing environment.", user: merchant_1)
asiago = Item.create!(name: "Asiago", price: 2.99, image: 'https://colosse.com/wp-content/uploads/2016/03/asiago-stock.jpg', inventory: 231, description: "Asiago is an Italian cow's milk cheese that can assume different textures, according to its aging, from smooth for the fresh Asiago to a crumbly texture for the aged cheese", user: merchant_7)
cheddar = Item.create!(name: "Cheddar", price: 1.99, image: 'https://cdn.shopify.com/s/files/1/0150/0232/products/Pearl_Valley_Extra_Sharp_White_Cheddar_large.jpg?v=1521490296', inventory: 456, description: "Cheddar cheese is a relatively hard, off-white, sometimes sharp-tasting, natural cheese. Originating in the English village of Cheddar in Somerset, cheeses of this style are produced beyond the region and in several countries around the world.", user: merchant_4)
roquefort= Item.create!(name: "Roquefort", price: 112.99, image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Wikicheese_-_Roquefort_-_20150417_-_003.jpg/1200px-Wikicheese_-_Roquefort_-_20150417_-_003.jpg', inventory: 99, description: "Roquefort is a sheep milk cheese from the south of France, and together with Bleu d'Auvergne, Danablu, Stilton, and Gorgonzola is one of the world's best known blue cheeses.", user: merchant_2)
havarti = Item.create!(name: "Havarti", price: 68.99, image: 'http://eshfoods.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/e/s/esh-058.jpg', inventory: 785, description: "Havarti or cream Havarti is a semisoft Danish cow's milk cheese. It is a table cheese that can be sliced, grilled, or melted.", user: merchant_2)
mozarella = Item.create!(name: "Mozarella", price: 112.99, image: 'https://www.seriouseats.com/recipes/images/2015/10/20151017-pies-vicky-wasik-2.jpg', inventory: 48, description: "Mozzarella is a traditionally southern Italian cheese made from Italian buffalo's milk by the pasta filata method. Mozzarella received a Traditional Specialities Guaranteed certification from the European Union in 1998.", user: merchant_2)
feta = Item.create!(name: "Feta", price: 12.99, image: 'https://cdn.shopify.com/s/files/1/2836/2982/products/Feta_hero_grande.jpg?v=1529434179', inventory: 234, description: "Feta is a brined curd white cheese made in Greece from sheep's milk or from a mixture of sheep and goat's milk. It is a crumbly aged cheese, commonly produced in blocks, and has a slightly grainy texture. Feta is used as a table cheese, as well as in salads and pastries.", user: merchant_7)
goat = Item.create!(name: "Goat", price: 32.99, image: 'https://www.thespruceeats.com/thmb/AWhVtBtt8qVJF9GfPuV5Az30RdM=/4494x3000/filters:fill(auto,1)/homemade-goat-cheese-with-lemon-juice-591553_15-5c40f7cbc9e77c0001f70d1d.jpg', inventory: 123, description: "Goat cheese, goats' cheese, or chèvre, is cheese made from goat's milk.", user: merchant_5)
manchego = Item.create!(name: "Manchego", price: 22.99, image: 'https://cdn.shopify.com/s/files/1/0676/7551/products/Manchego_900x600_62fc2c2c-a3d1-4ecb-8fda-4d86db974d26_grande.jpg?v=1494950801', inventory: 123, description: "Manchego is a cheese made in the La Mancha region of Spain from the milk of sheep of the Manchega breed. It is aged between 60 days and 2 years. Manchego has a firm and compact consistency and a buttery texture, and often contains small, unevenly distributed air pockets.", user: merchant_6)
provolone = Item.create!(name: "Provolone", price: 45.99, image: 'https://goldenagecheese.com/wp-content/uploads/2014/03/prov.jpg', inventory: 34, description: "Provolone is an Italian cheese. It is an aged pasta filata cheese originating in Casilli near Vesuvius, where it is still produced in pear, sausage, or cone shapes varying from 10 to 15 centimetres long. Provolone-type cheeses are also produced in other countries.", user: merchant_4)
ricotta = Item.create!(name: "Ricotta", price: 11.99, image: 'https://cdn-image.myrecipes.com/sites/default/files/styles/4_3_horizontal_-_1200x900/public/message-editor%252F1486504648057-ricotta-bowl-inline_0.jpg?itok=W3k7lNr1', inventory: 233, description: "Ricotta is an Italian whey cheese made from sheep, cow, goat, or Italian water buffalo milk whey left over from the production of other cheeses. Like other whey cheeses, it is made by coagulating the proteins that remain after the casein has been used to make cheese, notably albumin and globulin.", user: merchant_1)
gorgonzola = Item.create!(name: "Gorgonzola", price: 2.99, image: 'https://irepo.primecp.com/2016/03/258739/recipe-4195_Large400_ID-1450287.jpg?v=1450287', inventory: 897, description: "Gorgonzola is a veined Italian blue cheese, made from unskimmed cow's milk. It can be buttery or firm, crumbly and quite salty, with a 'bite' from its blue veining.", user: merchant_2)
gruyere= Item.create!(name: "Gruyere", price: 167.99, image: 'https://www.paxtonandwhitfield.co.uk/media/image/3c/0f/54/image_1_70HRDwajqPCIVo2_600x600.jpg', inventory: 753, description: "Gruyère is a hard yellow cheese that originated in the cantons of Fribourg, Vaud, Neuchâtel, Jura, and Berne in Switzerland. It is named after the town of Gruyères.", user: merchant_2)
camembert= Item.create!(name: "Camembert", price: 67.99, image: 'https://prods3.imgix.net/images/articles/2017_06/Non-featured-Camembert-Cheese-Shortage.jpg?auto=format%2Ccompress&ixjsv=2.2.3&w=670', inventory: 753, description: "Camembert is a moist, soft, creamy, surface-ripened cow's milk cheese. It was first made in the late 18th century at Camembert, Normandy, in northern France. It is similar to Brie, which is native to the Brie region of France.", user: merchant_4)
muenster = Item.create!(name: "Muenster", price: 22.99, image: 'https://cdn.shopify.com/s/files/1/0150/0232/products/Pearl_Valley_Meunster_Slices_grande.jpg?v=1534870969', inventory: 753, description: "Muenster or munster is a semi-soft cheese from the United States. It is thought to be an imitation of the Alsatian washed-rind Munster cheese, introduced by German immigrants. It is distinct from the processed dairy food Sweet Muenster Cheese.", user: merchant_3)
parmigiano_reggiano = Item.create!(name: "Parmigiano Reggiano", price: 222.99, image: 'https://richmedia.channeladvisor.com/ImageDelivery/imageService?profileId=12026540&id=777941&recipeId=728', inventory: 753, description: "Parmigiano-Reggiano is an Italian hard, granular cheese. The name 'Parmesan' is often used generically for the same cheese made outside the traditional areas of production in Italy, although this is prohibited in trading in the European Economic Area under European law.", user: merchant_5)
pepperjack = Item.create!(name: "Pepperjack", price: 222.99, image: 'https://cdn.shopify.com/s/files/1/0150/0232/products/Pearl_Valley_Pepper_Jack_Slices_large.jpg?v=1524071197', inventory: 753, description: "Pepper Jack is a derivative of Monterey Jack", user: merchant_6)
mascarpone = Item.create!(name: "Mascarpone", price: 222.99, image: 'https://cdn.shopify.com/s/files/1/2836/2982/products/mascarpone-recipe_grande.jpg?v=1529434182', inventory: 892, description: "Mascarpone is an Italian cream cheese coagulated by the addition of certain acidic substances such as lemon juice, vinegar or citric acid. It is recognized as a Prodotto agroalimentare tradizionale.", user: merchant_3)
swiss = Item.create!(name: "Swiss", price: 2.99, image: 'https://cdn.shopify.com/s/files/1/0150/0232/products/Pearl_Valley_Swiss_Slices_36762caf-0757-45d2-91f0-424bcacc9892_grande.jpg?v=1534871055', inventory: 892, description: "Swiss cheese is a generic name in North America for several related varieties of cheese, mainly of North American manufacture, which resemble Emmental cheese, a yellow, medium-hard cheese that originated in the area around Emmental, in Switzerland.", user: merchant_5)

buyer_1 = User.create!(email: 'buyer1@gmail.com', password: 'password', active: true, name: 'Jason Lovescheese', address: '1234 Test Dr', city: 'Denver', state: 'CO', zip: '80123')
buyer_1.locations.create!(name: 'home', city: 'Denver', state: 'CO', zip: '80123', address: '1234 Test Dr')
buyer_2 = User.create!(email: 'buyer2@gmail.com', password: 'password', active: true, name: 'Christina Grater', address: '1234 Test Dr', city: 'Kansas City', state: 'MO', zip: '80123')
buyer_3 = User.create!(email: 'buyer3@gmail.com', password: 'password', active: true, name: 'Jack Pepper', address: '1234 Test Dr', city: 'Boston', state: 'MA', zip: '80123')
buyer_4 = User.create!(email: 'buyer4@gmail.com', password: 'password', active: true, name: 'Jason Munster', address: '1234 Test Dr', city: 'Oakland', state: 'CA', zip: '80123')
buyer_5 = User.create!(email: 'buyer5@gmail.com', password: 'password', active: true, name: 'Linda Begood', address: '1234 Test Dr', city: 'Los Angelos', state: 'CA', zip: '80123')

order_1 = Order.create!(user: buyer_1, status: 2, updated_at: DateTime.now + 10)
order_2 = Order.create!(user: buyer_2, status: 2, updated_at: DateTime.now + 20)
order_3 = Order.create!(user: buyer_3, status: 2, updated_at: DateTime.now + 30)
order_4 = Order.create!(user: buyer_4, status: 2, updated_at: DateTime.now + 40)
order_5 = Order.create!(user: buyer_5, status: 2, updated_at: DateTime.now + 50)
order_6 = Order.create!(user: buyer_1, status: 2, updated_at: DateTime.now + 60)
order_7 = Order.create!(user: buyer_2, status: 2, updated_at: DateTime.now + 70)
order_8 = Order.create!(user: buyer_3, status: 2, updated_at: DateTime.now + 70)

order_item_1 = OrderItem.create!(item: gouda, order: order_1, quantity: 12, price: gouda.price, fulfilled: true)
order_item_2 = OrderItem.create!(item: brie, order: order_2, quantity: 2, price: brie.price, fulfilled: true)
order_item_3 = OrderItem.create!(item: asiago, order: order_3, quantity: 3, price: asiago.price, fulfilled: true)
order_item_4 = OrderItem.create!(item: cheddar, order: order_4, quantity: 4, price: cheddar.price, fulfilled: true)
order_item_5 = OrderItem.create!(item: roquefort, order: order_5, quantity: 5, price: roquefort.price, fulfilled: true)
order_item_6 = OrderItem.create!(item: pepperjack, order: order_6, quantity: 6, price: havarti.price, fulfilled: true)
order_item_7 = OrderItem.create!(item: mozarella, order: order_7, quantity: 2, price: mozarella.price, fulfilled: true)
order_item_8 = OrderItem.create!(item: feta, order: order_1, quantity: 3, price: feta.price, fulfilled: true)
order_item_9 = OrderItem.create!(item: goat, order: order_2, quantity: 4, price: goat.price, fulfilled: true)
order_item_10 = OrderItem.create!(item: manchego, order: order_3, quantity: 9, price: manchego.price, fulfilled: true)
order_item_11 = OrderItem.create!(item: provolone, order: order_4, quantity: 1, price: provolone.price, fulfilled: true)
order_item_12 = OrderItem.create!(item: ricotta, order: order_5, quantity: 21, price: ricotta.price, fulfilled: true)
order_item_13 = OrderItem.create!(item: gorgonzola, order: order_6, quantity: 3, price: gorgonzola.price, fulfilled: true)
order_item_14 = OrderItem.create!(item: gruyere, order: order_7, quantity: 4, price: gruyere.price, fulfilled: true)
order_item_15 = OrderItem.create!(item: camembert, order: order_1, quantity: 9, price: camembert.price, fulfilled: true)
order_item_16 = OrderItem.create!(item: gouda, order: order_2, quantity: 21, price: gouda.price, fulfilled: true)
order_item_17 = OrderItem.create!(item: brie, order: order_3, quantity: 4, price: brie.price, fulfilled: true)
order_item_18 = OrderItem.create!(item: asiago, order: order_4, quantity: 1, price: asiago.price, fulfilled: true)
order_item_19 = OrderItem.create!(item: cheddar, order: order_5, quantity: 2, price: cheddar.price, fulfilled: true)
order_item_20 = OrderItem.create!(item: havarti, order: order_6, quantity: 87, price: havarti.price, fulfilled: true)
order_item_21 = OrderItem.create!(item: mozarella, order: order_7, quantity: 23, price: mozarella.price, fulfilled: true)
order_item_22 = OrderItem.create!(item: feta, order: order_1, quantity: 1, price: feta.price, fulfilled: true)
order_item_23 = OrderItem.create!(item: goat, order: order_2, quantity: 6, price: goat.price, fulfilled: true)
order_item_24 = OrderItem.create!(item: manchego, order: order_3, quantity: 32, price: manchego.price, fulfilled: true)
order_item_25 = OrderItem.create!(item: gouda, order: order_4, quantity: 1, price: gouda.price, fulfilled: true)
order_item_26 = OrderItem.create!(item: swiss, order: order_8, quantity: 23, price: swiss.price, fulfilled: true)
order_item_27 = OrderItem.create!(item: mascarpone, order: order_8, quantity: 44, price: mascarpone.price, fulfilled: true)
order_item_28 = OrderItem.create!(item: parmigiano_reggiano, order: order_8, quantity: 44, price: parmigiano_reggiano.price, fulfilled: true)
order_item_29 = OrderItem.create!(item: muenster, order: order_7, quantity: 122, price: muenster.price, fulfilled: true)
order_item_30 = OrderItem.create!(item: muenster, order: order_6, quantity: 122, price: muenster.price, fulfilled: true)
order_item_31 = OrderItem.create!(item: parmigiano_reggiano, order: order_6, quantity: 44, price: parmigiano_reggiano.price, fulfilled: true)
