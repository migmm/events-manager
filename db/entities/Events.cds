namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Venues } from './Venues';
using { app.eventstickets.Categories } from './Categories';
using { app.eventstickets.Tickets } from './Tickets';
using { app.eventstickets.Reviews } from './Reviews';

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