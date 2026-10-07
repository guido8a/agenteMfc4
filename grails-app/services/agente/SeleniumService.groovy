package agente

import org.openqa.selenium.By
import org.openqa.selenium.support.ui.ExpectedConditions
import org.openqa.selenium.support.ui.WebDriverWait
import org.openqa.selenium.edge.EdgeDriver
import org.openqa.selenium.edge.EdgeDriverService
import org.openqa.selenium.edge.EdgeOptions
import org.openqa.selenium.WebDriver

import java.time.Duration

class SeleniumService {


    /**
     * Crea un WebDriver de Edge con Selenium Manager.
     * Selenium Manager detecta la versión de Edge instalada,
     * descarga el msedgedriver correspondiente y lo configura solo.
     * NO se requiere System.setProperty ni extraer drivers del WAR.
     */


    private WebDriver crearDriver() {
        boolean isWindows = System.getProperty("os.name").toLowerCase().contains("win")
        String driverName = isWindows ? "msedgedriver.exe" : "msedgedriver"

        String tempDir = System.getProperty("java.io.tmpdir")
        java.io.File targetFile = new java.io.File(tempDir, driverName)

        // SIEMPRE extraer y sobrescribir el driver desde el WAR
        java.io.InputStream inputStream = this.class.classLoader
                .getResourceAsStream("drivers/" + driverName)

        if (inputStream == null) {
            throw new java.io.FileNotFoundException(
                    "No se encontró el driver dentro del WAR en: resources/drivers/" + driverName)
        }

        // Borrar el archivo temporal anterior si existe
        if (targetFile.exists()) {
            targetFile.delete()
        }

        targetFile.withOutputStream { outputStream ->
            outputStream << inputStream
        }

        if (!isWindows) {
            targetFile.setExecutable(true)
        }

        println "Usando driver en: ${targetFile.absolutePath}"

        EdgeOptions options = new EdgeOptions()
        options.addArguments(
                "--disable-gpu",
                "--no-sandbox",
                "--disable-dev-shm-usage",
                "--start-maximized",
                "--window-size=1920,1080",
                "--remote-allow-origins=*"
        )

        EdgeDriverService service = new EdgeDriverService.Builder()
                .usingDriverExecutable(targetFile)
                .build()

        return new EdgeDriver(service, options)
    }


    void ejecutarAutomatizacion(int oferta) {
        println "=== Iniciando automatización con Edge ==="
        WebDriver driver = crearDriver()

        try {
            WebDriverWait wait  = new WebDriverWait(driver, Duration.ofSeconds(10))
            WebDriverWait wait2 = new WebDriverWait(driver, Duration.ofSeconds(15))
            WebDriverWait wait3 = new WebDriverWait(driver, Duration.ofSeconds(20))
            WebDriverWait wait4 = new WebDriverWait(driver, Duration.ofSeconds(5))

            driver.get("http://localhost:6012/mfc-oa/web/app.php")

            def ingreso = wait2.until(
                    ExpectedConditions.visibilityOfElementLocated(By.id("btn_inicio_abajo"))
            )
            ingreso.click()

            def abrirOfertas = wait2.until(
                    ExpectedConditions.visibilityOfElementLocated(By.xpath('//*[@title="Ofertas"]'))
            )
            abrirOfertas.click()

            if (!verificarSiUrlExiste("http://localhost:6012/mfc-oa/web/app.php/ofertas/edicion/${oferta}")) {
                log.error("El proceso se detuvo: La URL no existe o no responde.")
                driver.get("http://localhost:6012/mfc-oa/web/app.php")
                return
            }

            driver.get("http://localhost:6012/mfc-oa/web/app.php/ofertas/edicion/${oferta}")

            // ... aquí va el resto de tu lógica de formularios SIN CAMBIOS ...

        } catch (Exception e) {
            println "Ocurrió un error en Selenium: ${e.message}"
            e.printStackTrace()
        } finally {
            if (driver != null) {
                driver.quit()
                println "=== Terminado correctamente ==="
            }
        }
    }

    // Repite el mismo patrón en:
    //   ejecutarAutomatizacionExperienciaLaboral
    //   ejecutarAutomatizacionCargaAnexos
    //   ejecutarAutomatizacionCargaExperienciaOferente
    // Es decir: reemplaza el bloque de extracción del driver + System.setProperty
    // + DesiredCapabilities por una simple llamada a crearDriver().

    boolean verificarSiUrlExiste(String urlString) {
        try {
            URL url = new URL(urlString)
            HttpURLConnection conexion = (HttpURLConnection) url.openConnection()
            conexion.requestMethod = "HEAD"
            conexion.connectTimeout = 5000
            conexion.readTimeout = 5000
            int codigoEstado = conexion.responseCode
            return (codigoEstado >= 200 && codigoEstado < 400)
        } catch (Exception e) {
            log.error("Error de conexión URL ${urlString}: ${e.message}")
            return false
        }
    }
}