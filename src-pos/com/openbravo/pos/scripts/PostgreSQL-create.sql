--    Openbravo POS is a point of sales application designed for touch screens.
--    Copyright (C) 2007-2011 Openbravo, S.L.
--    http://sourceforge.net/projects/openbravopos
--
--    This file is part of Openbravo POS.
--
--    Openbravo POS is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    Openbravo POS is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with Openbravo POS.  If not, see <http://www.gnu.org/licenses/>.

-- Database initial script for POSTGRESQL
-- v2.30.2

CREATE TABLE APPLICATIONS (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    VERSION VARCHAR NOT NULL,
    PRIMARY KEY (ID)
);
INSERT INTO APPLICATIONS(ID, NAME, VERSION) VALUES($APP_ID{}, $APP_NAME{}, $APP_VERSION{});

CREATE TABLE HEADER(
    ID VARCHAR(255) NOT NULL,
    companyID VARCHAR(50),
    taxRegistrationNumber VARCHAR(9),
    companyName VARCHAR(60),
    businessName VARCHAR(60),
    addressDetail VARCHAR(60),
    buildingNumber VARCHAR(10),
    city VARCHAR(50),
    postalCode VARCHAR(8),
    region VARCHAR(50),
    country VARCHAR(50),
    telephone VARCHAR(10),
    fax VARCHAR(10),
    email VARCHAR(25),
    PRIMARY KEY (ID)
);

CREATE TABLE ROLES (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    PERMISSIONS BYTEA,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX ROLES_NAME_INX ON ROLES(NAME);
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('0', 'Administrator role', $FILE{/com/openbravo/pos/templates/Role.Administrator.xml} );
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('1', 'Manager role', $FILE{/com/openbravo/pos/templates/Role.Manager.xml} );
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('2', 'Employee role', $FILE{/com/openbravo/pos/templates/Role.Employee.xml} );
INSERT INTO ROLES(ID, NAME, PERMISSIONS) VALUES('3', 'Guest role', $FILE{/com/openbravo/pos/templates/Role.Guest.xml} );

CREATE TABLE PEOPLE (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    APPPASSWORD VARCHAR,
    CARD VARCHAR,
    ROLE VARCHAR NOT NULL,
    VISIBLE BOOLEAN NOT NULL,
    IMAGE BYTEA,
    PRIMARY KEY (ID),
    CONSTRAINT PEOPLE_FK_1 FOREIGN KEY (ROLE) REFERENCES ROLES(ID)
);
CREATE UNIQUE INDEX PEOPLE_NAME_INX ON PEOPLE(NAME);
CREATE INDEX PEOPLE_CARD_INX ON PEOPLE(CARD);

INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('0', 'Administrator', NULL, '0', TRUE, NULL);
INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('1', 'Manager', NULL, '1', TRUE, NULL);
INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('2', 'Employee', NULL, '2', TRUE, NULL);
INSERT INTO PEOPLE(ID, NAME, APPPASSWORD, ROLE, VISIBLE, IMAGE) VALUES ('3', 'Guest', NULL, '3', TRUE, NULL);

CREATE TABLE RESOURCES (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    RESTYPE INTEGER NOT NULL,
    CONTENT BYTEA,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX RESOURCES_NAME_INX ON RESOURCES(NAME);
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('0', 'Printer.Start', 0, $FILE{/com/openbravo/pos/templates/Printer.Start.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('1', 'Printer.Ticket', 0, $FILE{/com/openbravo/pos/templates/Printer.Ticket.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('2', 'Printer.Ticket2', 0, $FILE{/com/openbravo/pos/templates/Printer.Ticket2.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('3', 'Printer.TicketPreview', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketPreview.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('4', 'Printer.TicketTotal', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketTotal.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('5', 'Printer.OpenDrawer', 0, $FILE{/com/openbravo/pos/templates/Printer.OpenDrawer.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('6', 'Printer.Ticket.Logo', 1, $FILE{/com/openbravo/pos/templates/Printer.Ticket.Logo.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('7', 'Printer.TicketLine', 0, $FILE{/com/openbravo/pos/templates/Printer.TicketLine.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('8', 'Printer.CloseCash', 0, $FILE{/com/openbravo/pos/templates/Printer.CloseCash.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('9', 'Window.Logo', 1, $FILE{/com/openbravo/pos/templates/Window.Logo.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('10', 'Window.Title', 0, $FILE{/com/openbravo/pos/templates/Window.Title.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('11', 'Ticket.Buttons', 0, $FILE{/com/openbravo/pos/templates/Ticket.Buttons.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('12', 'Ticket.Line', 0, $FILE{/com/openbravo/pos/templates/Ticket.Line.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('13', 'Printer.Inventory', 0, $FILE{/com/openbravo/pos/templates/Printer.Inventory.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('14', 'Menu.Root', 0, $FILE{/com/openbravo/pos/templates/Menu.Root.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('15', 'Printer.CustomerPaid', 0, $FILE{/com/openbravo/pos/templates/Printer.CustomerPaid.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('16', 'Printer.CustomerPaid2', 0, $FILE{/com/openbravo/pos/templates/Printer.CustomerPaid2.xml});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('17', 'payment.cash', 0, $FILE{/com/openbravo/pos/templates/payment.cash.txt});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('18', 'banknote.50euro', 1, $FILE{/com/openbravo/pos/templates/banknote.50euro.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('19', 'banknote.20euro', 1, $FILE{/com/openbravo/pos/templates/banknote.20euro.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('20', 'banknote.10euro', 1, $FILE{/com/openbravo/pos/templates/banknote.10euro.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('21', 'banknote.5euro', 1, $FILE{/com/openbravo/pos/templates/banknote.5euro.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('22', 'coin.2euro', 1, $FILE{/com/openbravo/pos/templates/coin.2euro.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('23', 'coin.1euro', 1, $FILE{/com/openbravo/pos/templates/coin.1euro.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('24', 'coin.50cent', 1, $FILE{/com/openbravo/pos/templates/coin.50cent.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('25', 'coin.20cent', 1, $FILE{/com/openbravo/pos/templates/coin.20cent.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('26', 'coin.10cent', 1, $FILE{/com/openbravo/pos/templates/coin.10cent.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('27', 'coin.5cent', 1, $FILE{/com/openbravo/pos/templates/coin.5cent.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('28', 'coin.2cent', 1, $FILE{/com/openbravo/pos/templates/coin.2cent.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('29', 'coin.1cent', 1, $FILE{/com/openbravo/pos/templates/coin.1cent.png});
INSERT INTO RESOURCES(ID, NAME, RESTYPE, CONTENT) VALUES('30', 'Printer.PartialCash', 0, $FILE{/com/openbravo/pos/templates/Printer.PartialCash.xml});

CREATE TABLE TAXCUSTCATEGORIES (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX TAXCUSTCAT_NAME_INX ON TAXCUSTCATEGORIES(NAME);

CREATE TABLE CUSTOMERS (
    ID VARCHAR NOT NULL,
    SEARCHKEY VARCHAR NOT NULL,
    TAXID VARCHAR,
    NAME VARCHAR NOT NULL,
    TAXCATEGORY VARCHAR,
    CARD VARCHAR,
    MAXDEBT DOUBLE PRECISION DEFAULT 0 NOT NULL,
    ADDRESS VARCHAR,
    ADDRESS2 VARCHAR,
    POSTAL VARCHAR,
    CITY VARCHAR,
    REGION VARCHAR,
    COUNTRY VARCHAR,
    SHIPPINGADDRESS VARCHAR,
    SHIPPINGADDRESS2 VARCHAR,
    SHIPPINGPOSTAL VARCHAR,
    SHIPPINGCITY VARCHAR,
    SHIPPINGREGION VARCHAR,
    SHIPPINGCOUNTRY VARCHAR,
    FIRSTNAME VARCHAR,
    LASTNAME VARCHAR,
    EMAIL VARCHAR,
    PHONE VARCHAR,
    PHONE2 VARCHAR,
    FAX VARCHAR,
    NOTES VARCHAR,
    VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
    CURDATE TIMESTAMP,
    CURDEBT DOUBLE PRECISION,
    DEBTDATELIMIT VARCHAR NULL,
    DEBTMODE VARCHAR NULL,
    PRIMARY KEY (ID),
    CONSTRAINT CUSTOMERS_TAXCAT FOREIGN KEY (TAXCATEGORY) REFERENCES TAXCUSTCATEGORIES(ID)
);
CREATE UNIQUE INDEX CUSTOMERS_SKEY_INX ON CUSTOMERS(SEARCHKEY);
CREATE INDEX CUSTOMERS_TAXID_INX ON CUSTOMERS(TAXID);
CREATE INDEX CUSTOMERS_NAME_INX ON CUSTOMERS(NAME);
CREATE INDEX CUSTOMERS_CARD_INX ON CUSTOMERS(CARD);

CREATE TABLE CATEGORIES (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    PARENTID VARCHAR,
    IMAGE BYTEA,
    PRIMARY KEY(ID),
    CONSTRAINT CATEGORIES_FK_1 FOREIGN KEY (PARENTID) REFERENCES CATEGORIES(ID)
);
CREATE UNIQUE INDEX CATEGORIES_NAME_INX ON CATEGORIES(NAME);
INSERT INTO CATEGORIES(ID, NAME) VALUES ('000', 'Category standard');
INSERT INTO CATEGORIES(ID, NAME) VALUES ('0', 'Compositions');
INSERT INTO CATEGORIES(ID, NAME) VALUES ('-1', 'BOM');

CREATE TABLE TAXCATEGORIES (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX TAXCAT_NAME_INX ON TAXCATEGORIES(NAME);
INSERT INTO TAXCATEGORIES(ID, NAME) VALUES ('000', 'Tax Exempt');
INSERT INTO TAXCATEGORIES(ID, NAME) VALUES ('001', 'Tax Standard');
INSERT INTO TAXCATEGORIES(ID, NAME) VALUES ('-1', 'BOM');

CREATE TABLE TAXES (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    VALIDFROM TIMESTAMP DEFAULT '2001-01-01 00:00:00' NOT NULL,
    CATEGORY VARCHAR NOT NULL,
    CUSTCATEGORY VARCHAR,
    PARENTID VARCHAR,
    RATE DOUBLE PRECISION NOT NULL,
    RATECASCADE BOOLEAN NOT NULL DEFAULT FALSE,
    RATEORDER INTEGER,
    PRIMARY KEY(ID),
    CONSTRAINT TAXES_CAT_FK FOREIGN KEY (CATEGORY) REFERENCES TAXCATEGORIES(ID),
    CONSTRAINT TAXES_CUSTCAT_FK FOREIGN KEY (CUSTCATEGORY) REFERENCES TAXCUSTCATEGORIES(ID),
    CONSTRAINT TAXES_TAXES_FK FOREIGN KEY (PARENTID) REFERENCES TAXES(ID)
);
CREATE UNIQUE INDEX TAXES_NAME_INX ON TAXES(NAME);
INSERT INTO TAXES(ID, NAME, CATEGORY, CUSTCATEGORY, PARENTID, RATE, RATECASCADE, RATEORDER) VALUES ('000', 'Tax Exempt', '000', NULL, NULL, 0, 0, NULL);
INSERT INTO TAXES(ID, NAME, CATEGORY, CUSTCATEGORY, PARENTID, RATE, RATECASCADE, RATEORDER) VALUES ('001', 'Tax Standard', '001', NULL, NULL, 0.10, 0, NULL);
INSERT INTO TAXES(ID, NAME, CATEGORY, CUSTCATEGORY, PARENTID, RATE, RATECASCADE, RATEORDER) VALUES ('-1', 'BOM', '-1', NULL, NULL, 0.0, FALSE, NULL);

CREATE TABLE ATTRIBUTE (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE ATTRIBUTEVALUE (
    ID VARCHAR NOT NULL,
    ATTRIBUTE_ID VARCHAR NOT NULL,
    VALUE VARCHAR,
    PRIMARY KEY (ID),
    CONSTRAINT ATTVAL_ATT FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE(ID) ON DELETE CASCADE
);

CREATE TABLE ATTRIBUTESET (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE ATTRIBUTEUSE (
    ID VARCHAR NOT NULL,
    ATTRIBUTESET_ID VARCHAR NOT NULL,
    ATTRIBUTE_ID VARCHAR NOT NULL,
    LINENO INTEGER,
    PRIMARY KEY (ID),
    CONSTRAINT ATTUSE_SET FOREIGN KEY (ATTRIBUTESET_ID) REFERENCES ATTRIBUTESET(ID) ON DELETE CASCADE,
    CONSTRAINT ATTUSE_ATT FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE(ID)
);
CREATE UNIQUE INDEX ATTUSE_LINE ON ATTRIBUTEUSE(ATTRIBUTESET_ID, LINENO);

CREATE TABLE ATTRIBUTESETINSTANCE (
    ID VARCHAR NOT NULL,
    ATTRIBUTESET_ID VARCHAR NOT NULL,
    DESCRIPTION VARCHAR,
    PRIMARY KEY (ID),
    CONSTRAINT ATTSETINST_SET FOREIGN KEY (ATTRIBUTESET_ID) REFERENCES ATTRIBUTESET(ID) ON DELETE CASCADE
);

CREATE TABLE ATTRIBUTEINSTANCE (
    ID VARCHAR NOT NULL,
    ATTRIBUTESETINSTANCE_ID VARCHAR NOT NULL,
    ATTRIBUTE_ID VARCHAR NOT NULL,
    VALUE VARCHAR,
    PRIMARY KEY (ID),
    CONSTRAINT ATTINST_SET FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID) ON DELETE CASCADE,
    CONSTRAINT ATTINST_ATT FOREIGN KEY (ATTRIBUTE_ID) REFERENCES ATTRIBUTE(ID)
);

CREATE TABLE PRODUCTS (
    ID VARCHAR NOT NULL,
    REFERENCE VARCHAR NOT NULL,
    CODE VARCHAR NOT NULL,
    UNIT VARCHAR,
    CODETYPE VARCHAR,
    NAME VARCHAR NOT NULL,
    PRICEBUY DOUBLE PRECISION NOT NULL,
    PRICESELL DOUBLE PRECISION NOT NULL,
    CATEGORY VARCHAR NOT NULL,
    TAXCAT VARCHAR NOT NULL,
    ATTRIBUTESET_ID VARCHAR,
    STOCKCOST DOUBLE PRECISION,
    STOCKVOLUME DOUBLE PRECISION,
    IMAGE BYTEA,
    ISCOM BOOLEAN NOT NULL DEFAULT FALSE,
    ISSCALE BOOLEAN NOT NULL DEFAULT FALSE,
    ATTRIBUTES BYTEA,
    PRIMARY KEY (ID),
    CONSTRAINT PRODUCTS_FK_1 FOREIGN KEY (CATEGORY) REFERENCES CATEGORIES(ID),
    CONSTRAINT PRODUCTS_TAXCAT_FK FOREIGN KEY (TAXCAT) REFERENCES TAXCATEGORIES(ID),
    CONSTRAINT PRODUCTS_ATTRSET_FK FOREIGN KEY (ATTRIBUTESET_ID) REFERENCES ATTRIBUTESET(ID)
);
CREATE UNIQUE INDEX PRODUCTS_INX_0 ON PRODUCTS(REFERENCE);
CREATE UNIQUE INDEX PRODUCTS_INX_1 ON PRODUCTS(CODE);
CREATE UNIQUE INDEX PRODUCTS_NAME_INX ON PRODUCTS(NAME);

CREATE TABLE PRODUCTS_CAT (
    PRODUCT VARCHAR NOT NULL,
    CATORDER INTEGER,
    PRIMARY KEY (PRODUCT),
    CONSTRAINT PRODUCTS_CAT_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID)
);
CREATE INDEX PRODUCTS_CAT_INX_1 ON PRODUCTS_CAT(CATORDER);

CREATE TABLE PRODUCTS_COM (
    ID VARCHAR NOT NULL,
    PRODUCT VARCHAR NOT NULL,
    PRODUCT2 VARCHAR NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PRODUCTS_COM_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT PRODUCTS_COM_FK_2 FOREIGN KEY (PRODUCT2) REFERENCES PRODUCTS(ID)
);
CREATE UNIQUE INDEX PCOM_INX_PROD ON PRODUCTS_COM(PRODUCT, PRODUCT2);

CREATE TABLE PRODUCTS_MAT (
    PRODUCT VARCHAR NOT NULL,
    MATERIAL VARCHAR NOT NULL,
    AMOUNT DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (PRODUCT, MATERIAL),
    CONSTRAINT PROD_MAT_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT PROD_MAT_FK_2 FOREIGN KEY (MATERIAL) REFERENCES PRODUCTS(ID)
);

CREATE TABLE SUBGROUPS (
    ID VARCHAR NOT NULL,
    COMPOSITION VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    IMAGE BYTEA,
    PRIMARY KEY(ID),
    CONSTRAINT SUBGROUPS_FK_1 FOREIGN KEY (COMPOSITION) REFERENCES PRODUCTS(ID) ON DELETE CASCADE
);

CREATE TABLE SUBGROUPS_PROD (
    SUBGROUP VARCHAR NOT NULL,
    PRODUCT VARCHAR NOT NULL,
    PRIMARY KEY (SUBGROUP, PRODUCT),
    CONSTRAINT SUBGROUPS_PROD_FK_1 FOREIGN KEY (SUBGROUP) REFERENCES SUBGROUPS(ID) ON DELETE CASCADE,
    CONSTRAINT SUBGROUPS_PROD_FK_2 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID) ON DELETE CASCADE
);

CREATE TABLE LOCATIONS (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    ADDRESS VARCHAR,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX LOCATIONS_NAME_INX ON LOCATIONS(NAME);
INSERT INTO LOCATIONS(ID, NAME,ADDRESS) VALUES('0', 'General', NULL);

CREATE TABLE STOCKDIARY (
    ID VARCHAR NOT NULL,
    DATENEW TIMESTAMP NOT NULL,
    REASON INTEGER NOT NULL,
    LOCATION VARCHAR NOT NULL,
    PRODUCT VARCHAR NOT NULL,
    ATTRIBUTESETINSTANCE_ID VARCHAR,
    UNITS DOUBLE PRECISION NOT NULL,
    PRICE DOUBLE PRECISION NOT NULL,
    SUPPLIERID VARCHAR NULL,
    PRIMARY KEY (ID),
    CONSTRAINT STOCKDIARY_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT STOCKDIARY_ATTSETINST FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID),
    CONSTRAINT STOCKDIARY_FK_2 FOREIGN KEY (LOCATION) REFERENCES LOCATIONS(ID)
);
CREATE INDEX STOCKDIARY_INX_1 ON STOCKDIARY(DATENEW);

CREATE TABLE STOCKLEVEL (
    ID VARCHAR NOT NULL,
    LOCATION VARCHAR NOT NULL,
    PRODUCT VARCHAR NOT NULL,
    STOCKSECURITY DOUBLE PRECISION,
    STOCKMAXIMUM DOUBLE PRECISION,
    PRIMARY KEY (ID),
    CONSTRAINT STOCKLEVEL_PRODUCT FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT STOCKLEVEL_LOCATION FOREIGN KEY (LOCATION) REFERENCES LOCATIONS(ID)
);

CREATE TABLE STOCKCURRENT (
    LOCATION VARCHAR NOT NULL,
    PRODUCT VARCHAR NOT NULL,
    ATTRIBUTESETINSTANCE_ID VARCHAR,
    UNITS DOUBLE PRECISION NOT NULL,
    CONSTRAINT STOCKCURRENT_FK_1 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT STOCKCURRENT_ATTSETINST FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID),
    CONSTRAINT STOCKCURRENT_FK_2 FOREIGN KEY (LOCATION) REFERENCES LOCATIONS(ID)
);
CREATE UNIQUE INDEX STOCKCURRENT_INX ON STOCKCURRENT(LOCATION, PRODUCT, ATTRIBUTESETINSTANCE_ID);

CREATE TABLE CLOSEDCASH (
    MONEY VARCHAR NOT NULL,
    HOST VARCHAR NOT NULL,
    HOSTSEQUENCE INTEGER NOT NULL,
    DATESTART TIMESTAMP NOT NULL,
    DATEEND TIMESTAMP,
    PRIMARY KEY(MONEY)
);
CREATE INDEX CLOSEDCASH_INX_1 ON CLOSEDCASH(DATESTART);
CREATE UNIQUE INDEX CLOSEDCASH_INX_SEQ ON CLOSEDCASH(HOST, HOSTSEQUENCE);

CREATE TABLE RECEIPTS (
    ID VARCHAR NOT NULL,
    MONEY VARCHAR NOT NULL,
    DATENEW TIMESTAMP NOT NULL,
    ATTRIBUTES BYTEA,
    PRIMARY KEY(ID),
    CONSTRAINT RECEIPTS_FK_MONEY FOREIGN KEY (MONEY) REFERENCES CLOSEDCASH(MONEY)
);
CREATE INDEX RECEIPTS_INX_1 ON RECEIPTS(DATENEW);

CREATE TABLE TICKETS (
    ID VARCHAR NOT NULL,
    TICKETTYPE INTEGER DEFAULT 0 NOT NULL,
    TICKETID INTEGER NOT NULL,
    PERSON VARCHAR NOT NULL,
    CUSTOMER VARCHAR,
    STATUS INTEGER DEFAULT 0 NOT NULL,
    DUEDATE TIMESTAMP DEFAULT '1990-01-01 09:00:00' NOT NULL ,
    PRIMARY KEY (ID),
    CONSTRAINT TICKETS_FK_ID FOREIGN KEY (ID) REFERENCES RECEIPTS(ID),
    CONSTRAINT TICKETS_FK_2 FOREIGN KEY (PERSON) REFERENCES PEOPLE(ID),
    CONSTRAINT TICKETS_CUSTOMERS_FK FOREIGN KEY (CUSTOMER) REFERENCES CUSTOMERS(ID)
);
CREATE INDEX TICKETS_TICKETID ON TICKETS(TICKETTYPE, TICKETID);

CREATE SEQUENCE TICKETSNUM START WITH 1;
CREATE SEQUENCE TICKETSNUM_REFUND START WITH 1;
CREATE SEQUENCE TICKETSNUM_PAYMENT START WITH 1;

CREATE TABLE TICKETLINES (
    TICKET VARCHAR NOT NULL,
    LINE INTEGER NOT NULL,
    PRODUCT VARCHAR,
    ATTRIBUTESETINSTANCE_ID VARCHAR,
    UNITS DOUBLE PRECISION NOT NULL,
    PRICE DOUBLE PRECISION NOT NULL,
    TAXID VARCHAR NOT NULL,
    ATTRIBUTES BYTEA,
    PRIMARY KEY (TICKET, LINE),
    CONSTRAINT TICKETLINES_FK_TICKET FOREIGN KEY (TICKET) REFERENCES TICKETS(ID),
    CONSTRAINT TICKETLINES_FK_2 FOREIGN KEY (PRODUCT) REFERENCES PRODUCTS(ID),
    CONSTRAINT TICKETLINES_ATTSETINST FOREIGN KEY (ATTRIBUTESETINSTANCE_ID) REFERENCES ATTRIBUTESETINSTANCE(ID),
    CONSTRAINT TICKETLINES_FK_3 FOREIGN KEY (TAXID) REFERENCES TAXES(ID)
);

CREATE TABLE PAYMENTS (
    ID VARCHAR NOT NULL,
    RECEIPT VARCHAR NOT NULL,
    PAYMENT VARCHAR NOT NULL,
    TOTAL DOUBLE PRECISION NOT NULL,
    TRANSID VARCHAR,
    RETURNMSG BYTEA,
    CHEQUENUMBER VARCHAR,
    CHEQUEDATE VARCHAR,
    BANKNAME VARCHAR,
    TICKETID VARCHAR NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PAYMENTS_FK_RECEIPT FOREIGN KEY (RECEIPT) REFERENCES RECEIPTS(ID)
);
CREATE INDEX PAYMENTS_INX_1 ON PAYMENTS(PAYMENT);

CREATE TABLE TAXLINES (
    ID VARCHAR NOT NULL,
    RECEIPT VARCHAR NOT NULL,
    TAXID VARCHAR NOT NULL, 
    BASE DOUBLE PRECISION NOT NULL, 
    AMOUNT DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT TAXLINES_TAX FOREIGN KEY (TAXID) REFERENCES TAXES(ID),
    CONSTRAINT TAXLINES_RECEIPT FOREIGN KEY (RECEIPT) REFERENCES RECEIPTS(ID)
);

CREATE TABLE FLOORS (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    IMAGE BYTEA,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX FLOORS_NAME_INX ON FLOORS(NAME);
INSERT INTO FLOORS(ID, NAME, IMAGE) VALUES ('0', 'Restaurant floor', $FILE{/com/openbravo/pos/templates/restaurantsample.png});

CREATE TABLE PLACES (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    X INTEGER NOT NULL,
    Y INTEGER NOT NULL,
    FLOOR VARCHAR NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT PLACES_FK_1 FOREIGN KEY (FLOOR) REFERENCES FLOORS(ID)
);
CREATE UNIQUE INDEX PLACES_NAME_INX ON PLACES(NAME);
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('1', 'Table 1', 133, 151, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('2', 'Table 2', 532, 151, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('3', 'Table 3', 133, 264, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('4', 'Table 4', 266, 264, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('5', 'Table 5', 399, 264, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('6', 'Table 6', 532, 264, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('7', 'Table 7', 133, 377, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('8', 'Table 8', 266, 377, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('9', 'Table 9', 399, 377, '0');
INSERT INTO PLACES(ID, NAME, X, Y, FLOOR) VALUES ('10', 'Table 10', 532, 377, '0');

CREATE TABLE RESERVATIONS (
    ID VARCHAR NOT NULL,
    CREATED TIMESTAMP NOT NULL,
    DATENEW TIMESTAMP DEFAULT '2001-01-01 00:00:00' NOT NULL,
    TITLE VARCHAR NOT NULL,
    CHAIRS INTEGER NOT NULL,
    ISDONE BOOLEAN NOT NULL,
    DESCRIPTION VARCHAR,
    PRIMARY KEY (ID)
);
CREATE INDEX RESERVATIONS_INX_1 ON RESERVATIONS(DATENEW);

CREATE TABLE RESERVATION_CUSTOMERS (
    ID VARCHAR NOT NULL,
    CUSTOMER VARCHAR NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT RES_CUST_FK_1 FOREIGN KEY (ID) REFERENCES RESERVATIONS(ID),
    CONSTRAINT RES_CUST_FK_2 FOREIGN KEY (CUSTOMER) REFERENCES CUSTOMERS(ID)
);

CREATE TABLE THIRDPARTIES (
    ID VARCHAR NOT NULL,
    CIF VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    ADDRESS VARCHAR,
    CONTACTCOMM VARCHAR,
    CONTACTFACT VARCHAR,
    PAYRULE VARCHAR,
    FAXNUMBER VARCHAR,
    PHONENUMBER VARCHAR,
    MOBILENUMBER VARCHAR,
    EMAIL VARCHAR,
    WEBPAGE VARCHAR,
    NOTES VARCHAR,
    PRIMARY KEY (ID)
);
CREATE UNIQUE INDEX THIRDPARTIES_CIF_INX ON THIRDPARTIES(CIF);
CREATE UNIQUE INDEX THIRDPARTIES_NAME_INX ON THIRDPARTIES(NAME);

CREATE TABLE SUPPLIERS (
  ID VARCHAR NOT NULL,
  SEARCHKEY VARCHAR NOT NULL,
  TAXID VARCHAR DEFAULT NULL,
  NAME VARCHAR NOT NULL,
  TAXCATEGORY VARCHAR DEFAULT NULL,
  CARD VARCHAR DEFAULT NULL,
  MAXDEBT DOUBLE PRECISION DEFAULT 0 NOT NULL,
  ADDRESS VARCHAR DEFAULT NULL,
  ADDRESS2 VARCHAR DEFAULT NULL,
  POSTAL VARCHAR DEFAULT NULL,
  CITY VARCHAR DEFAULT NULL,
  REGION VARCHAR DEFAULT NULL,
  COUNTRY VARCHAR DEFAULT NULL,
  FIRSTNAME VARCHAR DEFAULT NULL,
  LASTNAME VARCHAR DEFAULT NULL,
  EMAIL VARCHAR DEFAULT NULL,
  PHONE VARCHAR DEFAULT NULL,
  PHONE2 VARCHAR DEFAULT NULL,
  FAX VARCHAR DEFAULT NULL,
  NOTES VARCHAR DEFAULT NULL,
  VISIBLE BOOLEAN NOT NULL DEFAULT TRUE,
  CURDATE TIMESTAMP,
  CURDEBT DOUBLE PRECISION,
  PRIMARY KEY (ID),
  CONSTRAINT SUPPLIERS_TAXCAT FOREIGN KEY (TAXCATEGORY) REFERENCES TAXCUSTCATEGORIES(ID)
);
CREATE UNIQUE INDEX SUPPLIERS_SKEY_INX ON SUPPLIERS(SEARCHKEY);
CREATE INDEX SUPPLIERS_TAXID_INX ON SUPPLIERS(TAXID);
CREATE INDEX SUPPLIERS_NAME_INX ON SUPPLIERS(NAME);
CREATE INDEX SUPPLIERS_CARD_INX ON SUPPLIERS(CARD);

CREATE TABLE SHAREDTICKETS (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    CONTENT BYTEA,
    PRIMARY KEY (ID)
);

CREATE TABLE UNITS (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    SYMBOL VARCHAR NOT NULL,
    PRIMARY KEY(ID)
);
CREATE UNIQUE INDEX UNITS_NAME_INX ON UNITS(NAME);

CREATE TABLE BANKS (
    ID VARCHAR NOT NULL,
    NAME VARCHAR NOT NULL,
    CODE VARCHAR NOT NULL,
    PRIMARY KEY(ID)
);
CREATE UNIQUE INDEX BANKS_NAME_INX ON BANKS(NAME);

CREATE TABLE MATERIALS_UNITS (
    MATERIAL VARCHAR NOT NULL,
    UNIT VARCHAR NOT NULL,
    AMOUNT DOUBLE PRECISION NOT NULL,
    PRICEBUY DOUBLE PRECISION NOT NULL,
    PRIMARY KEY(MATERIAL, UNIT),
    CONSTRAINT MAT_UNIT_FK_1 FOREIGN KEY (MATERIAL) REFERENCES PRODUCTS(ID),
    CONSTRAINT MAT_UNIT_FK_2 FOREIGN KEY (UNIT) REFERENCES UNITS(ID)
);

CREATE TABLE SHIFTS (
  ID VARCHAR NOT NULL,
  STARTSHIFT TIMESTAMP NOT NULL,
  ENDSHIFT TIMESTAMP,
  PPLID VARCHAR NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE LEAVES (
  ID VARCHAR NOT NULL,
  PPLID VARCHAR NOT NULL,
  NAME VARCHAR NOT NULL,
  STARTDATE TIMESTAMP NOT NULL,
  ENDDATE TIMESTAMP NOT NULL,
  NOTES VARCHAR,
  PRIMARY KEY (ID),
  CONSTRAINT lEAVES_PPLID FOREIGN KEY (PPLID) REFERENCES PEOPLE(ID)
);

CREATE TABLE BREAKS (
  ID VARCHAR NOT NULL,
  NAME VARCHAR NOT NULL,
  NOTES VARCHAR,
  VISIBLE BOOLEAN NOT NULL,
  PRIMARY KEY (ID)
);

INSERT INTO BREAKS(ID, NAME, VISIBLE, NOTES) VALUES ('0', 'Lunch Break', TRUE, NULL);
INSERT INTO BREAKS(ID, NAME, VISIBLE, NOTES) VALUES ('1', 'Tea Break', TRUE, NULL);
INSERT INTO BREAKS(ID, NAME, VISIBLE, NOTES) VALUES ('2', 'Mid Break', TRUE, NULL);

CREATE TABLE SHIFT_BREAKS (
  ID VARCHAR NOT NULL,
  SHIFTID VARCHAR NOT NULL,
  BREAKID VARCHAR NOT NULL,
  STARTTIME TIMESTAMP NOT NULL,
  ENDTIME TIMESTAMP,
  PRIMARY KEY (ID),
  CONSTRAINT SHIFT_BREAKS_BREAKID FOREIGN KEY (BREAKID) REFERENCES BREAKS(ID),
  CONSTRAINT SHIFT_BREAKS_SHIFTID FOREIGN KEY (SHIFTID) REFERENCES SHIFTS(ID)
);
