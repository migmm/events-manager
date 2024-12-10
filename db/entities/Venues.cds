namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Events } from './Events';

entity Venues : cuid, managed {
    Name             : String(100) not null @assert.maxLength: 100;
    Address          : String(255) not null;
    Capacity         : Integer @assert.range: [0, 100000];
    Events           : Composition of many Events on Events.Location = $self;
}
