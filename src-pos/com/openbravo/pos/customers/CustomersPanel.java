//    Upsources POS is a point of sales application designed for touch screens.
//    Copyright (C) 2007-2009 Openbravo, S.L.
//    http://www.openbravo.com/product/pos
//
//    This file is part of Upsources POS.
//
//    Upsources POS is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    Upsources POS is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Upsources POS.  If not, see <http://www.gnu.org/licenses/>.

package com.openbravo.pos.customers;

import com.openbravo.basic.BasicException;
import com.openbravo.data.gui.ListCellRendererBasic;
import com.openbravo.data.loader.ComparatorCreator;
import com.openbravo.data.loader.TableDefinition;
import com.openbravo.data.loader.Vectorer;
import com.openbravo.data.user.EditorRecord;
import com.openbravo.data.user.ListProvider;
import com.openbravo.data.user.ListProviderCreator;
import com.openbravo.data.user.SaveProvider;
import com.openbravo.pos.forms.AppLocal;
import com.openbravo.pos.panels.JPanelTable;
import javax.swing.ListCellRenderer;

/**
 *
 * @author adrianromero
 */
public class CustomersPanel extends JPanelTable {
    
    private TableDefinition tcustomers;
    private CustomersView jeditor;
    
    /** Creates a new instance of CustomersPanel */
    public CustomersPanel() {    
    }
    
    protected void init() {        
        DataLogicCustomers dlCustomers  = (DataLogicCustomers) app.getBean("com.openbravo.pos.customers.DataLogicCustomers");
        tcustomers = dlCustomers.getTableCustomers();        
        jeditor = new CustomersView(app, dirty);    
    }
    
    @Override
    public void activate() throws BasicException { 
        
        jeditor.activate();         
        super.activate();
    }
    
    public ListProvider getListProvider() {
        return new ListProviderCreator(tcustomers);
    }


    // MSL
    public SaveProvider getSaveProvider() {
        return new SaveProvider(tcustomers, new int[] {0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34});
    }
    
    @Override
    public Vectorer getVectorer() {
        return tcustomers.getVectorerBasic(new int[]{1, 2, 3, 4});
    }
    
    @Override
    public ComparatorCreator getComparatorCreator() {
        return tcustomers.getComparatorCreator(new int[] {1, 2, 3, 4});
    }
    
    @Override
    public ListCellRenderer getListCellRenderer() {
        return new ListCellRendererBasic(tcustomers.getRenderStringBasic(new int[]{3}));
    }
    
    public EditorRecord getEditor() {
        return jeditor;
    }       
    
    public String getTitle() {
        return AppLocal.getIntString("Menu.CustomersManagement");
    }    
}
