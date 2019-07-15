package account;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import config.TestConfig;
import dao.prototype.ISearchRecordDao;
import entity.Song;
import entity.User;
import service.prototype.ICollectService;
import service.prototype.ISeachRecordService;
import service.prototype.ISongService;
import service.prototype.IUserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes=TestConfig.class)
public class SearchTest {
	@Autowired
	private ISeachRecordService seachRecordService;
	
	@Test
	public void testFindAll(){
		seachRecordService.keywordTopTen();
	}

}
