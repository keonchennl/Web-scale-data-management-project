package WDM.controller;

import WDM.pojo.Stock;
import WDM.service.StockService;
import io.seata.core.exception.TransactionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


@RestController
@EnableEurekaClient
@RequestMapping("stock")
public class StockController {
    @Autowired
    private StockService stockService;

    //    /stock/find/{item_id}
    //    GET - returns an item’s availability and price.
    //    Output JSON fields:
    //            “stock” - the item’s stock
    //            “price” - the item’s price
    @GetMapping("find/{itemId}")
    public Map<String, Object> queryById(@PathVariable("itemId") String id) {
        Stock stock = stockService.queryById(id);
        Map<String, Object> map = new HashMap<>(2);
        if (stock == null) {
            map.put("400", "item not found!");
        } else {
            map.put("stock", stock.getAmount());
            map.put("price", stock.getPrice());
        }
        return map;
    }

    //    /stock/subtract/{item_id}/{amount}
    //    POST - subtracts an item from stock by the amount specified.
    @PostMapping("subtract/{itemId}/{amount}")
    public String subtract(@PathVariable("itemId") String id, @PathVariable("amount") int amount) throws TransactionException {
        if (stockService.subtract(id, amount)) {
            return "200";
        } else {
            return "400";
        }
    }

    ///stock/add/{item_id}/{amount}
    //    POST - adds the given number of stock items to the item count in the stock
    @PostMapping("add/{itemId}/{amount}")
    public String add(@PathVariable("itemId") String id, @PathVariable("amount") int amount) {
        if (stockService.add(id, amount) == Boolean.TRUE) {
            return "200";
        } else {
            return "400";
        }
    }

    ///stock/item/create/{price}
    //    POST - adds an item and its price, and returns its ID.
    //    Output JSON fields:
    //            “item_id” - the item’s id
    @PostMapping("item/create/{price}")
    public Map<String, String> create(@PathVariable("price") double price) {
        String itemId = stockService.create(price);
        Map<String, String> map = new HashMap<>();
        map.put("item_id", itemId);
        return map;
    }
}
