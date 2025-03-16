products = [
  {name: 'Беспроводная колонка Goodyear Bluetooth Speaker', price: 1600, stock_quantity: 1000 },
  {name: 'Женский домашний костюм Sweet Dreams', price: 800, stock_quantity: 1000 },
  {name: 'Плащ-дождевик SwissOak', price: 800, stock_quantity: 1000 }
]

products.each do |product|
  Product.create!(product)
end

puts 'Seeded database!'