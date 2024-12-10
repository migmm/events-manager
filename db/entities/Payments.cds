
namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Tickets } from './Tickets';

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
    PaymentMethod_ID : Association to PaymentMethods not null;
    Status_ID        : Association to PaymentStatuses not null;
}