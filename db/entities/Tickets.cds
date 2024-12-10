namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Events } from './Events';
using { app.eventstickets.Users } from './Users';
using { app.eventstickets.Payments } from './Payments';
using { app.eventstickets.Discounts } from './Discounts';

entity TicketStatuses : cuid, managed {
    StatusName       : String(50) not null @assert.maxLength: 50;
    Description      : String(255);
}

entity TicketTypes : cuid, managed {
    TypeName         : String(50) not null @assert.maxLength: 50;
    Description      : String(255);
    Price            : Decimal(10,2) @assert.range: [0, 10000];
}

entity Tickets : cuid, managed {
    Event_ID         : Association to Events not null;
    User_ID          : Association to Users not null;
    Discount_ID      : Association to Discounts;
    Status_ID        : Association to TicketStatuses;
    Type_ID          : Association to TicketTypes;
   
    PurchaseDate     : DateTime @assert.notEmpty;
    Seat             : String(20);
   
    Payment          : Association to Payments;
}