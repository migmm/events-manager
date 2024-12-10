namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Events } from './Events';
using { app.eventstickets.Users } from './Users';

entity Reviews : cuid, managed {
    Event_ID         : Association to Events not null;
    User_ID          : Association to Users not null;
    Rating           : Integer @assert.range: [1, 5];
    Comment          : String(500);
    ReviewDate       : DateTime @assert.notEmpty;
}