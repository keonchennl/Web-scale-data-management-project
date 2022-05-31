package WDM.service.Impl;

import WDM.mapper.StockMapper;
import WDM.pojo.Stock;
import WDM.service.StockService;
import feign.FeignException;
import io.seata.core.context.RootContext;
import io.seata.core.exception.TransactionException;
import io.seata.tm.api.GlobalTransactionContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Slf4j
@Service
public class StockServiceImpl implements StockService {

    @Autowired
    StockMapper stockMapper;

    @Override
    @Transactional
    public Stock queryById(String id) {
        return stockMapper.queryById(id);
    }

    @Override
    @Transactional
    public Boolean subtract(String id, int amount) throws TransactionException, FeignException {

        log.info("Seata global transaction id=================>{}", RootContext.getXID());
        RootContext.bind(RootContext.getXID());
        try {
            stockMapper.subtract(id, amount);
        } catch (Exception e) {
            GlobalTransactionContext.reload(RootContext.getXID()).rollback();
            log.info("Stock exception: Seata global transaction id=================>{}",RootContext.getXID());
            return false;
        }
        return true;
    }

    @Override
    @Transactional
    public Boolean add(String id, int amount) {
        return stockMapper.add(id, amount);
    }

    @Override
    public String create(double price) {
        String id = UUID.randomUUID().toString();
        stockMapper.create(id, price);
        return id;
    }
}
