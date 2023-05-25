it('should visit the root page', () => {
  cy.visit('/');
});

it("There are products on the page", () => {
  cy.get(".products article").should("be.visible");
});

it("There are 2 products on the page", () => {
  cy.get(".products article").should("have.length", 2);
});

it("Should add an item to cart when the button is clicked", () => {
  cy.get('.btn:first').click({ force: true });
  cy.contains('My Cart').invoke('text').should('include', '1');
});