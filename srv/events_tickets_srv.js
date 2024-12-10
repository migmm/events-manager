const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

    const { Events, Tickets, Reviews, Payments, Discounts } = this.entities;

    // Create an event
    this.on('CreateEvent', async req => {
        const { Name, Date, Location, AvailableSeats, Price, Category } = req.data;
        return await INSERT.into(Events).entries({
            Name, Date, Location_ID: Location, AvailableSeats, Price, Category_ID: Category
        });
    });

    // Buy a ticket
    this.on('PurchaseTicket', async req => {
        const { Event_ID, User_ID, Discount_ID, Type_ID, Seat } = req.data;
        return await INSERT.into(Tickets).entries({
            Event_ID, User_ID, Discount_ID, Type_ID, Seat, PurchaseDate: new Date()
        });
    });

    // Add review
    this.on('AddReview', async req => {
        const { Event_ID, User_ID, Rating, Comment } = req.data;
        return await INSERT.into(Reviews).entries({
            Event_ID, User_ID, Rating, Comment, ReviewDate: new Date()
        });
    });

    // Apply discount
    this.on('ApplyDiscount', async req => {
        const { Ticket_ID, Discount_ID } = req.data;
        await UPDATE(Tickets, Ticket_ID).with({ Discount_ID });
        return await SELECT.from(Tickets).where({ ID: Ticket_ID });
    });

    // Pay
    this.on('MakePayment', async req => {
        const { Ticket_ID, PaymentMethod_ID, Amount } = req.data;
        return await INSERT.into(Payments).entries({
            Ticket_ID, PaymentMethod_ID, Amount, PaymentDate: new Date()
        });
    });
});