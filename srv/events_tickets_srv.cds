using { app.eventstickets as my } from '../db/entities/entities';

service EventTicketsService {

    entity Categories as projection on my.Categories;
    entity Discounts as projection on my.Discounts;
    entity Events as projection on my.Events;
    entity PaymentMethods as projection on my.PaymentMethods;
    entity PaymentStatuses as projection on my.PaymentStatuses;
    entity Payments as projection on my.Payments;
    entity Reviews as projection on my.Reviews;
    entity TicketStatuses as projection on my.TicketStatuses;
    entity TicketTypes as projection on my.TicketTypes;
    entity Tickets as projection on my.Tickets;
    entity Users as projection on my.Users;
    entity Venues as projection on my.Venues;

    action CreateEvent (
        Name : String(100),
        Date : DateTime,
        Location : UUID,
        AvailableSeats : Integer,
        Price : Decimal(10,2),
        Category : UUID
    ) returns Events;

    action PurchaseTicket (
        Event_ID : UUID,
        User_ID : UUID,
        Discount_ID : UUID,
        Type_ID : UUID,
        Seat : String(20)
    ) returns Tickets;

    action AddReview (
        Event_ID : UUID,
        User_ID : UUID,
        Rating : Integer,
        Comment : String(500)
    ) returns Reviews;

    action ApplyDiscount (
        Ticket_ID : UUID,
        Discount_ID : UUID
    ) returns Tickets;

    action MakePayment (
        Ticket_ID : UUID,
        PaymentMethod_ID : UUID,
        Amount : Decimal(10,2)
    ) returns Payments;
}