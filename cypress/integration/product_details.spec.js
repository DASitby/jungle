it('should visit the root page', () => {
  cy.visit('/');
});

it("There are products on the page", () => {
  cy.get(".products article").should("be.visible");
});

it("There are 2 products on the page", () => {
  cy.get(".products article").should("have.length", 2);
});

it("should navigate to the product page when clicking on a product", () => {
  cy.get(".products article").eq(0).click();
  cy.url().should('match', /\/products\/\d+/);
});