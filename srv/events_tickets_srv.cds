namespace app.eventstickets;

using app.eventstickets from '../db/entities';

service EventsTicketsService {
    entity Events as projection on eventstickets.Events; 
    entity Tickets as projection on eventstickets.Tickets;
    entity Users as projection on eventstickets.Users;   

    action BuyTicket(Event_ID: String, User_ID: String) returns Boolean;
}
