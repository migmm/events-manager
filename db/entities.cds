namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';

entity Events : cuid, managed {
    Name             : String(100) not null @assert.maxLength: 100;
    Date             : DateTime @assert.notEmpty;
    Location         : String @assert.notEmpty;
    AvailableSeats   : Integer @assert.range: [0, 10000];
    Price            : Decimal(10,2) @assert.range: [0, 10000];

    Tickets          : Composition of many Tickets on Tickets.Event_ID = $self;
}

entity Tickets : cuid, managed {
    Event_ID         : Association to Events not null;
    User_ID          : Association to Users not null;
    PurchaseDate     : DateTime @assert.notEmpty;
    Status           : String @assert.notEmpty @assert.in: ['Buyed', 'Cancelled'];
}

entity Users : cuid, managed {
    FirstName        : String(100) not null @assert.maxLength: 100;
    LastName         : String(100) not null @assert.maxLength: 100;
    Email            : String(255) not null @assert.format: 'email';
    PhoneNumber      : String(20) not null @assert.maxLength: 20;
}
