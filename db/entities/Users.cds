
namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Tickets } from './Tickets';

entity Users : cuid, managed {
    FirstName        : String(100) not null @assert.maxLength: 100;
    LastName         : String(100) not null @assert.maxLength: 100;
    Email            : String(255) not null @assert.format: 'email';
    PhoneNumber      : String(20) not null @assert.maxLength: 20;
    Tickets          : Composition of many Tickets on Tickets.User_ID = $self;
}
