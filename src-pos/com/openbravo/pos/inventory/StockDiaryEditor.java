//    Openbravo POS is a point of sales application designed for touch screens.
//    Copyright (C) 2007-2008 Openbravo, S.L.
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

package com.openbravo.pos.inventory;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Date;
import java.util.UUID;
import com.openbravo.beans.DateUtils;
import com.openbravo.beans.JCalendarDialog;
import com.openbravo.basic.BasicException;
import com.openbravo.data.gui.ComboBoxValModel;
import com.openbravo.data.gui.MessageInf;
import com.openbravo.data.loader.SentenceList;
import com.openbravo.format.Formats;
import com.openbravo.data.user.DirtyManager;
import com.openbravo.data.user.EditorRecord;
import com.openbravo.pos.catalog.CatalogSelector;
import com.openbravo.pos.forms.AppLocal;
import com.openbravo.pos.forms.AppView;
import com.openbravo.pos.forms.DataLogicSales;
import com.openbravo.pos.catalog.JCatalog;
import com.openbravo.pos.panels.JProductFinder;
import com.openbravo.pos.ticket.ProductInfoExt;
import java.awt.Dimension;

/**
 *
 * @author adrianromero
 */
public class StockDiaryEditor extends javax.swing.JPanel implements EditorRecord {
    
    private CatalogSelector m_cat;

    private String m_sID;
    private ProductInfoExt m_product;
    
    private ComboBoxValModel m_ReasonModel;
    
    private SentenceList m_sentlocations;
    private ComboBoxValModel m_LocationsModel;    

    private AppView m_App;
    private DataLogicSales m_dlSales;
    
    /** Creates new form StockDiaryEditor */
    public StockDiaryEditor(AppView app, DirtyManager dirty) {
        
        m_App = app;
        m_dlSales = (DataLogicSales) m_App.getBean("com.openbravo.pos.forms.DataLogicSales");
        
        initComponents();      
        
        m_cat = new JCatalog(m_dlSales);
        m_cat.getComponent().setPreferredSize(new Dimension(0, 245));
        m_cat.addActionListener(new CatalogListener());
        add(m_cat.getComponent(), BorderLayout.SOUTH);

        // El modelo de locales
        m_sentlocations = m_dlSales.getLocationsList();
        m_LocationsModel = new ComboBoxValModel();
        
        m_ReasonModel = new ComboBoxValModel();
        m_ReasonModel.add(MovementReason.IN_PURCHASE);
        m_ReasonModel.add(MovementReason.IN_REFUND);
        m_ReasonModel.add(MovementReason.IN_MOVEMENT);
        m_ReasonModel.add(MovementReason.OUT_SALE);
        m_ReasonModel.add(MovementReason.OUT_REFUND);
        m_ReasonModel.add(MovementReason.OUT_BREAK);
        m_ReasonModel.add(MovementReason.OUT_MOVEMENT);        
        m_jreason.setModel(m_ReasonModel);
        
        m_jdate.getDocument().addDocumentListener(dirty);
        m_jreason.addActionListener(dirty);
        m_jLocation.addActionListener(dirty);
        m_jproduct.getDocument().addDocumentListener(dirty);
        m_junits.getDocument().addDocumentListener(dirty);
        m_jprice.getDocument().addDocumentListener(dirty);
         
        writeValueEOF();
    }
    
    public void activate() throws BasicException {
        m_cat.loadCatalog();
        
        m_LocationsModel = new ComboBoxValModel(m_sentlocations.list());
        m_jLocation.setModel(m_LocationsModel); // para que lo refresque   
    }
    
    public void refresh() {
    }
    
    public void writeValueEOF() {
        m_sID = null;
        m_jdate.setText(null);
        m_ReasonModel.setSelectedKey(null);
        m_product = null;
        m_jreference.setText(null);
        m_jcodebar.setText(null);
        m_LocationsModel.setSelectedKey(m_App.getInventoryLocation());
        m_jproduct.setText(null);
        m_junits.setText(null);
        m_jprice.setText(null);
        m_jdate.setEnabled(false);
        m_jbtndate.setEnabled(false);
        m_jreason.setEnabled(false);
        m_jreference.setEnabled(false);
        m_jEnter1.setEnabled(false);
        m_jcodebar.setEnabled(false);
        m_jEnter.setEnabled(false);
        m_jLocation.setEnabled(false);
        m_jproduct.setEnabled(false);
        m_jbtnproduct.setEnabled(false);
        m_junits.setEnabled(false);
        m_jprice.setEnabled(false);
        m_cat.setComponentEnabled(false);
    }
    
    public void writeValueInsert() {
        m_sID = null;
        m_jdate.setText(Formats.TIMESTAMP.formatValue(DateUtils.getTodayMinutes()));
        m_ReasonModel.setSelectedItem(MovementReason.IN_PURCHASE);
        m_product = null;
        m_jreference.setText(null);
        m_jcodebar.setText(null);
        m_LocationsModel.setSelectedKey(m_App.getInventoryLocation());
        m_jproduct.setText(null);
        m_jcodebar.setText(null);
        m_junits.setText(null);
        m_jprice.setText(null);
        m_jdate.setEnabled(true);
        m_jbtndate.setEnabled(true);
        m_jreason.setEnabled(true);
        m_jreference.setEnabled(true);
        m_jEnter1.setEnabled(true);
        m_jcodebar.setEnabled(true);
        m_jEnter.setEnabled(true);
        m_jLocation.setEnabled(true);
        m_jproduct.setEnabled(true);
        m_jbtnproduct.setEnabled(true);
        m_junits.setEnabled(true);
        m_jprice.setEnabled(true);   
        m_cat.setComponentEnabled(true);
    }

    public void writeValueDelete(Object value) {
        Object[] diary = (Object[]) value;
        m_sID = (String) diary[0];
        m_jdate.setText(Formats.TIMESTAMP.formatValue(diary[1]));
        m_ReasonModel.setSelectedKey(diary[2]);
        m_LocationsModel.setSelectedKey(diary[3]);
        m_product = getProduct((String) diary[4]);
        m_jreference.setText(m_product.getReference());
        m_jcodebar.setText(m_product.getCode());
        m_jproduct.setText(m_product.toString());
        m_junits.setText(Formats.DOUBLE.formatValue(signum((Double)diary[5], (Integer) diary[2])));
        m_jprice.setText(Formats.CURRENCY.formatValue(diary[6]));
        m_jdate.setEnabled(false);
        m_jbtndate.setEnabled(false);
        m_jreason.setEnabled(false);
        m_jreference.setEnabled(false);
        m_jEnter1.setEnabled(false);
        m_jcodebar.setEnabled(false);
        m_jEnter.setEnabled(false);
        m_jLocation.setEnabled(false);
        m_jproduct.setEnabled(false);
        m_jbtnproduct.setEnabled(false);
        m_junits.setEnabled(false);
        m_jprice.setEnabled(false);   
        m_cat.setComponentEnabled(false);
    }
    
    public void writeValueEdit(Object value) {
        Object[] diary = (Object[]) value;
        m_sID = (String) diary[0];
        m_jdate.setText(Formats.TIMESTAMP.formatValue(diary[1]));
        m_ReasonModel.setSelectedKey(diary[2]);
        m_LocationsModel.setSelectedKey(diary[3]);
        m_product = getProduct((String) diary[4]);
        m_jreference.setText(m_product.getReference());
        m_jcodebar.setText(m_product.getCode());
        m_jproduct.setText(m_product.toString());
        m_junits.setText(Formats.DOUBLE.formatValue(signum((Double)diary[5], (Integer) diary[2])));
        m_jprice.setText(Formats.CURRENCY.formatValue(diary[6]));
        m_jdate.setEnabled(false);
        m_jbtndate.setEnabled(false);
        m_jreason.setEnabled(false);
        m_jreference.setEnabled(false);
        m_jEnter1.setEnabled(false);
        m_jcodebar.setEnabled(false);
        m_jEnter.setEnabled(false);
        m_jLocation.setEnabled(false);
        m_jproduct.setEnabled(false);
        m_jbtnproduct.setEnabled(false);
        m_junits.setEnabled(false);
        m_jprice.setEnabled(false);  
        m_cat.setComponentEnabled(false);
    }
    
    public Object createValue() throws BasicException {
        Object[] diary = new Object[7];
        diary[0] = m_sID == null ? UUID.randomUUID().toString() : m_sID; // si casca que suba la excepcion hacia arriba.
        diary[1] = Formats.TIMESTAMP.parseValue(m_jdate.getText());
        diary[2] = m_ReasonModel.getSelectedKey();
        diary[3] = m_LocationsModel.getSelectedKey();
        diary[4] = (m_product == null) ? null : m_product.getID();
        diary[5] = samesignum((Double) Formats.DOUBLE.parseValue(m_junits.getText()), (Integer) diary[2]);
        diary[6] = Formats.CURRENCY.parseValue(m_jprice.getText());
        return diary;
    }
    
    public Component getComponent() {
        return this;
    }
 
    private ProductInfoExt getProduct(String id)  {
        
        try {
            return m_dlSales.getProductInfo(id);
        } catch (BasicException e) {
            return null;
        }
    } 
    
    private Double signum(Double d, Integer i) {
        if (d == null || i == null) {
            return d;
        } else if (i.intValue() < 0) {
            return new Double(-d.doubleValue());
        } else {
            return d;
        } 
    }
    
    private Double samesignum(Double d, Integer i) {
        
        if (d == null || i == null) {
            return d;
        } else if ((i.intValue() > 0 && d.doubleValue() < 0.0) ||
            (i.intValue() < 0 && d.doubleValue() > 0.0)) {
            return new Double(-d.doubleValue());
        } else {
            return d;
        }            
    }
    
    private void assignProduct(ProductInfoExt prod) {
        
        if (m_jproduct.isEnabled()) {
            if (prod == null) {
                m_product = null;
                m_jproduct.setText(null);
                m_jcodebar.setText(null);
                m_jreference.setText(null);
            } else {
                m_product = prod;
                m_jproduct.setText(m_product.toString());
                m_jcodebar.setText(m_product.getCode());
                m_jreference.setText(m_product.getReference());

                // calculo el precio sugerido para la entrada.
                MovementReason reason = (MovementReason)  m_ReasonModel.getSelectedItem();
                Double dPrice = reason.getPrice(m_product.getPriceBuy(), m_product.getPriceSell());
                m_jprice.setText(Formats.CURRENCY.formatValue(dPrice));
            }
        }
    }
    
    private void assignProductByCode() {
        try {
            ProductInfoExt oProduct = m_dlSales.getProductInfoByCode(m_jcodebar.getText());
            if (oProduct == null) {       
                assignProduct(null);
                Toolkit.getDefaultToolkit().beep();                   
            } else {
                // Se anade directamente una unidad con el precio y todo
                assignProduct(oProduct);
            }
        } catch (BasicException eData) {        
            assignProduct(null);
            MessageInf msg = new MessageInf(eData);
            msg.show(this);            
        }        
    }
    
    private void assignProductByReference() {
        try {
            ProductInfoExt oProduct = m_dlSales.getProductInfoByReference(m_jreference.getText());
            if (oProduct == null) {       
                assignProduct(null);
                Toolkit.getDefaultToolkit().beep();                   
            } else {
                // Se anade directamente una unidad con el precio y todo
                assignProduct(oProduct);
            }
        } catch (BasicException eData) {        
            assignProduct(null);
            MessageInf msg = new MessageInf(eData);
            msg.show(this);            
        }        
    }
    
    private class CatalogListener implements ActionListener {
        public void actionPerformed(ActionEvent e) {
            assignProduct((ProductInfoExt) e.getSource());
        }  
    }    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jLabel1 = new javax.swing.JLabel();
        m_jdate = new javax.swing.JTextField();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        m_jproduct = new javax.swing.JTextField();
        m_jreason = new javax.swing.JComboBox();
        m_jbtnproduct = new javax.swing.JButton();
        m_jbtndate = new javax.swing.JButton();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        m_junits = new javax.swing.JTextField();
        m_jprice = new javax.swing.JTextField();
        m_jcodebar = new javax.swing.JTextField();
        m_jEnter = new javax.swing.JButton();
        m_jreference = new javax.swing.JTextField();
        m_jEnter1 = new javax.swing.JButton();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        m_jLocation = new javax.swing.JComboBox();
        jLabel8 = new javax.swing.JLabel();

        setLayout(new java.awt.BorderLayout());

        jPanel1.setLayout(null);

        jLabel1.setText(AppLocal.getIntString("label.stockdate")); // NOI18N
        jPanel1.add(jLabel1);
        jLabel1.setBounds(10, 30, 150, 15);
        jPanel1.add(m_jdate);
        m_jdate.setBounds(160, 30, 200, 19);

        jLabel2.setText(AppLocal.getIntString("label.stockreason")); // NOI18N
        jPanel1.add(jLabel2);
        jLabel2.setBounds(10, 60, 150, 15);

        jLabel3.setText(AppLocal.getIntString("label.stockproduct")); // NOI18N
        jPanel1.add(jLabel3);
        jLabel3.setBounds(10, 120, 150, 15);

        m_jproduct.setEditable(false);
        jPanel1.add(m_jproduct);
        m_jproduct.setBounds(160, 180, 250, 19);
        jPanel1.add(m_jreason);
        m_jreason.setBounds(160, 60, 200, 20);

        m_jbtnproduct.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/openbravo/images/viewmag.png"))); // NOI18N
        m_jbtnproduct.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                m_jbtnproductActionPerformed(evt);
            }
        });
        jPanel1.add(m_jbtnproduct);
        m_jbtnproduct.setBounds(420, 180, 40, 26);

        m_jbtndate.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/openbravo/images/date.png"))); // NOI18N
        m_jbtndate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                m_jbtndateActionPerformed(evt);
            }
        });
        jPanel1.add(m_jbtndate);
        m_jbtndate.setBounds(370, 30, 40, 26);

        jLabel4.setText(AppLocal.getIntString("label.units")); // NOI18N
        jPanel1.add(jLabel4);
        jLabel4.setBounds(10, 210, 150, 15);

        jLabel5.setText(AppLocal.getIntString("label.price")); // NOI18N
        jPanel1.add(jLabel5);
        jLabel5.setBounds(10, 240, 150, 15);

        m_junits.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jPanel1.add(m_junits);
        m_junits.setBounds(160, 210, 70, 19);

        m_jprice.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jPanel1.add(m_jprice);
        m_jprice.setBounds(160, 240, 70, 19);

        m_jcodebar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                m_jcodebarActionPerformed(evt);
            }
        });
        jPanel1.add(m_jcodebar);
        m_jcodebar.setBounds(280, 150, 130, 19);

        m_jEnter.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/openbravo/images/apply.png"))); // NOI18N
        m_jEnter.setFocusPainted(false);
        m_jEnter.setFocusable(false);
        m_jEnter.setRequestFocusEnabled(false);
        m_jEnter.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                m_jEnterActionPerformed(evt);
            }
        });
        jPanel1.add(m_jEnter);
        m_jEnter.setBounds(420, 150, 40, 26);

        m_jreference.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                m_jreferenceActionPerformed(evt);
            }
        });
        jPanel1.add(m_jreference);
        m_jreference.setBounds(280, 120, 130, 19);

        m_jEnter1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/com/openbravo/images/apply.png"))); // NOI18N
        m_jEnter1.setFocusPainted(false);
        m_jEnter1.setFocusable(false);
        m_jEnter1.setRequestFocusEnabled(false);
        m_jEnter1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                m_jEnter1ActionPerformed(evt);
            }
        });
        jPanel1.add(m_jEnter1);
        m_jEnter1.setBounds(420, 120, 40, 26);

        jLabel6.setText(AppLocal.getIntString("label.prodref")); // NOI18N
        jPanel1.add(jLabel6);
        jLabel6.setBounds(160, 120, 120, 15);

        jLabel7.setText(AppLocal.getIntString("label.prodbarcode")); // NOI18N
        jPanel1.add(jLabel7);
        jLabel7.setBounds(160, 150, 120, 15);
        jPanel1.add(m_jLocation);
        m_jLocation.setBounds(160, 90, 200, 20);

        jLabel8.setText(AppLocal.getIntString("label.warehouse")); // NOI18N
        jPanel1.add(jLabel8);
        jLabel8.setBounds(10, 90, 150, 15);

        add(jPanel1, java.awt.BorderLayout.CENTER);
    }// </editor-fold>//GEN-END:initComponents

    private void m_jEnter1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_m_jEnter1ActionPerformed

        assignProductByReference();
        
    }//GEN-LAST:event_m_jEnter1ActionPerformed

    private void m_jreferenceActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_m_jreferenceActionPerformed

        assignProductByReference();

    }//GEN-LAST:event_m_jreferenceActionPerformed

    private void m_jcodebarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_m_jcodebarActionPerformed
       
        assignProductByCode();

    }//GEN-LAST:event_m_jcodebarActionPerformed

    private void m_jEnterActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_m_jEnterActionPerformed
            
        assignProductByCode();
   
    }//GEN-LAST:event_m_jEnterActionPerformed

    private void m_jbtnproductActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_m_jbtnproductActionPerformed

        assignProduct(JProductFinder.showMessage(this, m_dlSales));
        
    }//GEN-LAST:event_m_jbtnproductActionPerformed

    private void m_jbtndateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_m_jbtndateActionPerformed
        
        Date date;
        try {
            date = (Date) Formats.TIMESTAMP.parseValue(m_jdate.getText());
        } catch (BasicException e) {
            date = null;
        }        
        date = JCalendarDialog.showCalendarTime(this, date);
        if (date != null) {
            m_jdate.setText(Formats.TIMESTAMP.formatValue(date));
        }
        
    }//GEN-LAST:event_m_jbtndateActionPerformed
    
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JButton m_jEnter;
    private javax.swing.JButton m_jEnter1;
    private javax.swing.JComboBox m_jLocation;
    private javax.swing.JButton m_jbtndate;
    private javax.swing.JButton m_jbtnproduct;
    private javax.swing.JTextField m_jcodebar;
    private javax.swing.JTextField m_jdate;
    private javax.swing.JTextField m_jprice;
    private javax.swing.JTextField m_jproduct;
    private javax.swing.JComboBox m_jreason;
    private javax.swing.JTextField m_jreference;
    private javax.swing.JTextField m_junits;
    // End of variables declaration//GEN-END:variables
    
}
