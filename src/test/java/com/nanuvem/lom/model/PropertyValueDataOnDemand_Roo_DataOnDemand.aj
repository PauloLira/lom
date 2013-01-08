// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.nanuvem.lom.model;

import com.nanuvem.lom.dao.PropertyValueDAO;
import com.nanuvem.lom.model.InstanceDataOnDemand;
import com.nanuvem.lom.model.PropertyDataOnDemand;
import com.nanuvem.lom.model.PropertyValue;
import com.nanuvem.lom.model.PropertyValueDataOnDemand;
import com.nanuvem.lom.service.PropertyValueService;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect PropertyValueDataOnDemand_Roo_DataOnDemand {
    
    declare @type: PropertyValueDataOnDemand: @Component;
    
    private Random PropertyValueDataOnDemand.rnd = new SecureRandom();
    
    private List<PropertyValue> PropertyValueDataOnDemand.data;
    
    @Autowired
    private InstanceDataOnDemand PropertyValueDataOnDemand.instanceDataOnDemand;
    
    @Autowired
    private PropertyDataOnDemand PropertyValueDataOnDemand.propertyDataOnDemand;
    
    @Autowired
    PropertyValueService PropertyValueDataOnDemand.propertyValueService;
    
    @Autowired
    PropertyValueDAO PropertyValueDataOnDemand.propertyValueDAO;
    
    public PropertyValue PropertyValueDataOnDemand.getNewTransientPropertyValue(int index) {
        PropertyValue obj = new PropertyValue();
        set_value(obj, index);
        return obj;
    }
    
    public void PropertyValueDataOnDemand.set_value(PropertyValue obj, int index) {
        String _value = "_value_" + index;
        obj.set_value(_value);
    }
    
    public PropertyValue PropertyValueDataOnDemand.getSpecificPropertyValue(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        PropertyValue obj = data.get(index);
        Long id = obj.getId();
        return propertyValueService.findPropertyValue(id);
    }
    
    public PropertyValue PropertyValueDataOnDemand.getRandomPropertyValue() {
        init();
        PropertyValue obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return propertyValueService.findPropertyValue(id);
    }
    
    public boolean PropertyValueDataOnDemand.modifyPropertyValue(PropertyValue obj) {
        return false;
    }
    
    public void PropertyValueDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = propertyValueService.findPropertyValueEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'PropertyValue' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<PropertyValue>();
        for (int i = 0; i < 10; i++) {
            PropertyValue obj = getNewTransientPropertyValue(i);
            try {
                propertyValueService.savePropertyValue(obj);
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            propertyValueDAO.flush();
            data.add(obj);
        }
    }
    
}
