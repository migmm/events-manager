namespace app.eventstickets;

using { cuid, managed } from '@sap/cds/common';
using { app.eventstickets.Events } from './Events';

entity Categories : cuid, managed {
    Name             : String(100) not null @assert.maxLength: 100;
    Description      : String(255);
    Events           : Composition of many Events on Events.Category = $self;
}