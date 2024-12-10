namespace app.eventstickets;
using { cuid, managed } from '@sap/cds/common';

entity Events : cuid, managed {
    Name             : String(100) not null @assert.maxLength: 100;
    Date             : DateTime @assert.notEmpty;
    Location         : Association to Venues;
    AvailableSeats   : Integer @assert.range: [0, 10000];
    Price            : Decimal(10,2) @assert.range: [0, 10000];
    Category         : Association to Categories;
    Tickets          : Composition of many Tickets on Tickets.Event_ID = $self;
    Reviews          : Composition of many Reviews on Reviews.Event_ID = $self;
}

entity Tickets : cuid, managed {
    Event_ID         : Association to Events not null;
    User_ID          : Association to Users not null;
    PurchaseDate     : DateTime @assert.notEmpty;
    Status           : String @assert.notEmpty @assert.in: ['Buyed', 'Cancelled'];
    Payment          : Association to Payments;
}

entity Users : cuid, managed {
    FirstName        : String(100) not null @assert.maxLength: 100;
    LastName         : String(100) not null @assert.maxLength: 100;
    Email            : String(255) not null @assert.format: 'email';
    PhoneNumber      : String(20) not null @assert.maxLength: 20;
    Tickets          : Composition of many Tickets on Tickets.User_ID = $self;
}

entity Categories : cuid, managed {
    Name             : String(100) not null @assert.maxLength: 100;
    Description      : String(255);
    Events           : Composition of many Events on Events.Category = $self;
}

entity PaymentMethods : cuid, managed {
    MethodName       : String(50) not null @assert.maxLength: 50;
    Payments         : Composition of many Payments on Payments.PaymentMethod_ID = $self;
}

entity PaymentStatuses : cuid, managed {
    StatusName       : String(50) not null @assert.maxLength: 50;
    Payments         : Composition of many Payments on Payments.Status_ID = $self;
}

entity Payments : cuid, managed {
    Ticket_ID        : Association to Tickets not null;
    PaymentDate      : DateTime not null;
    Amount           : Decimal(10,2) @assert.range: [0, 10000];
    PaymentMethod_ID : Association to PaymentMethods not null; // Relación con métodos de pago
    Status_ID        : Association to PaymentStatuses not null; // Relación con estados de pago
}


entity Reviews : cuid, managed {
    Event_ID         : Association to Events not null;
    User_ID          : Association to Users not null;
    Rating           : Integer @assert.range: [1, 5];
    Comment          : String(500);
    ReviewDate       : DateTime @assert.notEmpty;
}

entity Venues : cuid, managed {
    Name             : String(100) not null @assert.maxLength: 100;
    Address          : String(255) not null;
    Capacity         : Integer @assert.range: [0, 100000];
    Events           : Composition of many Events on Events.Location = $self;
}

entity Discounts : cuid, managed {
    Code             : String(20) not null @assert.maxLength: 20;
    Description      : String(255);
    DiscountAmount   : Decimal(10,2) @assert.range: [0, 10000];
    Tickets          : Association to many Tickets;
}