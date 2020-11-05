package myProject;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.spi.DocumentationType;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

import springfox.documentation.service.ApiInfo;
import springfox.documentation.builders.ApiInfoBuilder;


@Configuration
@EnableSwagger2
public class SpringFoxConfig {                                    

	@Bean
	public Docket myDocket() {
		return new Docket(DocumentationType.SWAGGER_2)
				.apiInfo(apiInfo())
				.select()
				.apis(RequestHandlerSelectors.basePackage("myProject"))
				.paths(PathSelectors.any())
				.build();
	}
	
	private ApiInfo apiInfo() {
		return new ApiInfoBuilder()
				.title("Cytalk Backend")
				.description("Backend for Cytalk ComS 309")
				.build();
	}

}
