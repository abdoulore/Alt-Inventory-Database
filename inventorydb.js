// created collections
db.createCollection('categories')
db.createCollection('users')
db.createCollection('items')
db.createCollection('orders')
db.createCollection('order_items')

// insert data
db.categories.insertOne({ _id: 1, name: 'Electronics', created_at: Date() });
db.categories.insertOne({ _id: 2, name: 'Clothes', created_at: Date() });

db.users.insertOne({ _id: 1, name: 'Admin1', email: 'admin1@x.com', password: 'qwerty123', role: 'ADMIN', created_at: Date() });
db.users.insertOne({ _id: 2, name: 'User1', email: 'user1@x.com', password: 'qwerty456', role: 'USER', created_at: Date() });
db.users.insertOne({ _id: 3, name: 'Admin2', email: 'admin2@x.com', password: 'qwerty1234', role: 'ADMIN', created_at: Date() });
db.users.insertOne({ _id: 4, name: 'User2', email: 'user2@x.com', password: 'qwerty4567', role: 'USER', created_at: Date() });

db.items.insertOne({ _id: 1, name: 'Mouse', price: 20.00, size: 'SMALL', category_id: 1, created_at: Date() });
db.items.insertOne({ _id: 2, name: 'Shirt', price: 50.00, size: 'MEDIUM', category_id: 2, created_at: Date() });
db.items.insertOne({ _id: 3, name: 'Cloak', price: 90.00, size: 'LARGE', category_id: 2, created_at: Date() });
db.items.insertOne({ _id: 4, name: 'Tshirt', price: 40.00, size: 'MEDIUM', category_id: 2, created_at: Date() });

db.orders.insertOne({ _id: 1, user_id: 2, status: 'PENDING', approved_by: null, created_at: Date() });
db.orders.insertOne({ _id: 2, user_id: 4, status: 'PENDING', approved_by: null, created_at: Date() });
db.orders.insertOne({ _id: 3, user_id: 4, status: 'PENDING', approved_by: null, created_at: Date() });

db.order_items.insertOne({ _id: 1, order_id: 1, item_id: 1, quantity: 2, created_at: Date() });
db.order_items.insertOne({ _id: 2, order_id: 2, item_id: 2, quantity: 4, created_at: Date() });

// update item 
db.items.updateOne(
  { _id: 3 },
  { $set: { name: 'Big Cloak' } }
);

// update order
db.orders.updateOne(
  { _id: 1 },
  { $set: { status: 'APPROVED', approved_by: 1 } }
);

// delete item
db.items.deleteOne(
  { _id: 4 }
);

// delete order
db.orders.deleteOne(
  { _id: 3 }
);

// query data
db.categories.find({ _id: 1 })
db.categories.findOne({ _id: 2 })

db.items.find({ category_id: 2 })
db.orders.findOne({ _id: 1 })

// get all items with categories using lookup
db.items.aggregate([
  {
    $lookup: {
      from: 'categories',
      localField: 'category_id',
      foreignField: '_id',
      as: 'categories'
    }
  }
])

// get all orders with users using lookup
db.orders.aggregate([
  {
    $lookup: {
      from: 'users',
      localField: 'user_id',
      foreignField: '_id',
      as: 'users'
    }
  }
])