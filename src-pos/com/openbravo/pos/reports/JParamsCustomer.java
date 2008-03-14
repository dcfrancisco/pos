//    Openbravo POS is a point of sales application designed for touch screens.
//    Copyright (C) 2007 Openbravo, S.L.
//    http://sourceforge.net/projects/openbravopos
//
//    This program is free software; you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation; either version 2 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

package com.openbravo.pos.reports;

import com.openbravo.basic.BasicException;
import com.openbravo.data.loader.QBFCompareEnum;
import com.openbravo.data.user.EditorCreator;
import com.openbravo.pos.customers.DataLogicCustomers;
import com.openbravo.pos.customers.JCustomerFinder;
import com.openbravo.pos.forms.AppLocal;
import com.openbravo.pos.customers.CustomerInfo;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

/**
 *
 * @author  adrianromero
 */
public class JParamsCustomer extends javax.swing.JPanel implements EditorCreator {
    
    private DataLogicCustomers dlCustomers;
    private CustomerInfo currentcustomer;
    
    /** Creates new form JParamsCustomer */
    public JParamsCustomer(DataLogicCustomers dlCustomers) {
        
        this.dlCustomers = dlCustomers;

        initComponents();
        
        jTextField1.getDocument().addDocumentListener(new DocumentListener() {
            public void insertUpdate(DocumentEvent e) {
                currentcustomer = null;
            }
            public void removeUpdate(DocumentEvent e) {
                currentcustomer = null;
            }
            public void changedUpdate(DocumentEvent e) {
                currentcustomer = null;
            }
        });
    }
    
    public void activate() {
        
        currentcustomer = null;
        jTextField1.setText(null);        
    }
    
    public Object createValue() throws BasicException {
        
        if (currentcustomer == null) {
            if (jTextField1.getText() == null || jTextField1.getText().equals("")) {
                return new Object[] {QBFCompareEnum.COMP_NONE, null, QBFCompareEnum.COMP_NONE, null};
            } else {
                return new Object[] {QBFCompareEnum.COMP_NONE, null, QBFCompareEnum.COMP_RE, jTextField1.getText()};
            }
        } else {
            return new Object[] {QBFCompareEnum.COMP_EQUALS, currentcustomer.getId(), QBFCompareEnum.COMP_NONE, null};
        }
    }     
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jTextField1 = new javax.swing.JTextField();
        btnCustomer = new javax.swing.JButton();

        setBorder(javax.swing.BorderFactory.createTitledBorder(AppLocal.getIntString("label.bycustomer"))); // NOI18N
        setPreferredSize(new java.awt.Dimension(400, 60));
        setLayout(null);

        jLabel1.setText(AppLocal.getIntString("label.customer")); // NOI18N
        add(jLabel1);
        jLabel1.setBounds(20, 20, 70, 14);
        add(jTextField1);
        jTextField1.setBounds(160, 20, 210, 20);

        btnCustomer.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/openbravo/images/kuser.png"))); // NOI18N
        btnCustomer.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnCustomerActionPerformed(evt);
            }
        });
        add(btnCustomer);
        btnCustomer.setBounds(380, 20, 50, 26);
    }// </editor-fold>//GEN-END:initComponents

    private void btnCustomerActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnCustomerActionPerformed

        JCustomerFinder finder = JCustomerFinder.getCustomerFinder(this, dlCustomers);
        finder.search(currentcustomer);
        finder.setVisible(true);
        currentcustomer = finder.getSelectedCustomer();
        if (currentcustomer == null) {
            jTextField1.setText(null);
        } else {
            jTextField1.setText(currentcustomer.getName());
        }
        
    }//GEN-LAST:event_btnCustomerActionPerformed
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnCustomer;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JTextField jTextField1;
    // End of variables declaration//GEN-END:variables
    
}
