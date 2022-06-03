package WDM;

import feign.clients.OrderClient;
import feign.clients.StockClient;
import io.seata.spring.annotation.datasource.EnableAutoDataSourceProxy;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@MapperScan("WDM.mapper")
@SpringBootApplication
@EnableFeignClients(clients = {OrderClient.class, StockClient.class})
@EnableAutoDataSourceProxy
public class PaymentApplication {
    public static void main(String[] args) {
        SpringApplication.run(PaymentApplication.class,args);
    }
}