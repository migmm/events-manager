const cds = require('@sap/cds');
const { Events, Tickets, Users } = cds.entities;

module.exports = cds.service.impl(async function () {

    this.on('BuyTicket', async (req) => {
        const { Event_ID, User_ID } = req.data;

        const eventIdObj = { ID: Event_ID };
        const userIdObj = { ID: User_ID };

        const event = await SELECT.one.from(Events).where(eventIdObj);
        if (!event) {
            throw new Error('Event not found.');
        }

        const user = await SELECT.one.from(Users).where(userIdObj);
        if (!user) {
            throw new Error('User not found.');
        }

        if (event.AvailableSeats <= 0) {
            throw new Error('No seats available.');
        }

        await INSERT.into(Tickets).entries({
            Event_ID: eventIdObj,
            User_ID: userIdObj,
            PurchaseDate: new Date(),
            Status: 'Buyed',
        });

        await UPDATE(Events).set({
            AvailableSeats: event.AvailableSeats - 1
        }).where(eventIdObj);

        return true;
    });
});