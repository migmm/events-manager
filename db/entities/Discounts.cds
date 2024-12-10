namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Tickets } from './Tickets';

entity Discounts : cuid, managed {
    Code             : String(20) not null @assert.maxLength: 20;
    Description      : String(255);
    DiscountAmount   : Decimal(10,2) @assert.range: [0, 10000];
    Tickets          : Association to many Tickets on Tickets.Discount_ID = $self;
}