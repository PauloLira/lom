// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.nanuvem.lom.model;

import com.nanuvem.lom.dao.InstanceDAO;
import com.nanuvem.lom.model.InstanceDataOnDemand;
import com.nanuvem.lom.model.InstanceIntegrationTest;
import com.nanuvem.lom.service.InstanceService;
import java.util.List;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect InstanceIntegrationTest_Roo_IntegrationTest {
    
    declare @type: InstanceIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: InstanceIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext*.xml");
    
    declare @type: InstanceIntegrationTest: @Transactional;
    
    @Autowired
    private InstanceDataOnDemand InstanceIntegrationTest.dod;
    
    @Autowired
    InstanceService InstanceIntegrationTest.instanceService;
    
    @Autowired
    InstanceDAO InstanceIntegrationTest.instanceDAO;
    
    @Test
    public void InstanceIntegrationTest.testCountAllInstances() {
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", dod.getRandomInstance());
        long count = instanceService.countAllInstances();
        Assert.assertTrue("Counter for 'Instance' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void InstanceIntegrationTest.testFindInstance() {
        Instance obj = dod.getRandomInstance();
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Instance' failed to provide an identifier", id);
        obj = instanceService.findInstance(id);
        Assert.assertNotNull("Find method for 'Instance' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Instance' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void InstanceIntegrationTest.testFindAllInstances() {
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", dod.getRandomInstance());
        long count = instanceService.countAllInstances();
        Assert.assertTrue("Too expensive to perform a find all test for 'Instance', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Instance> result = instanceService.findAllInstances();
        Assert.assertNotNull("Find all method for 'Instance' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Instance' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void InstanceIntegrationTest.testFindInstanceEntries() {
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", dod.getRandomInstance());
        long count = instanceService.countAllInstances();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Instance> result = instanceService.findInstanceEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'Instance' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Instance' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void InstanceIntegrationTest.testFlush() {
        Instance obj = dod.getRandomInstance();
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Instance' failed to provide an identifier", id);
        obj = instanceService.findInstance(id);
        Assert.assertNotNull("Find method for 'Instance' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyInstance(obj);
        Integer currentVersion = obj.getVersion();
        instanceDAO.flush();
        Assert.assertTrue("Version for 'Instance' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void InstanceIntegrationTest.testUpdateInstanceUpdate() {
        Instance obj = dod.getRandomInstance();
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Instance' failed to provide an identifier", id);
        obj = instanceService.findInstance(id);
        boolean modified =  dod.modifyInstance(obj);
        Integer currentVersion = obj.getVersion();
        Instance merged = instanceService.updateInstance(obj);
        instanceDAO.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Instance' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void InstanceIntegrationTest.testSaveInstance() {
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", dod.getRandomInstance());
        Instance obj = dod.getNewTransientInstance(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Instance' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Instance' identifier to be null", obj.getId());
        instanceService.saveInstance(obj);
        instanceDAO.flush();
        Assert.assertNotNull("Expected 'Instance' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void InstanceIntegrationTest.testDeleteInstance() {
        Instance obj = dod.getRandomInstance();
        Assert.assertNotNull("Data on demand for 'Instance' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Instance' failed to provide an identifier", id);
        obj = instanceService.findInstance(id);
        instanceService.deleteInstance(obj);
        instanceDAO.flush();
        Assert.assertNull("Failed to remove 'Instance' with identifier '" + id + "'", instanceService.findInstance(id));
    }
    
}
