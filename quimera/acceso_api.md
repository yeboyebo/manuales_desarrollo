# Acceso a la API de Pineboo

## Acceso logueado
[TO DO]

## Acceso en aplicaciones sin login
[TO DO]

## Acceso no logueado en aplicaciones con login
Hay ciertos casos en los que, aun estando en una aplicación que exige login, debemos acceder a la API sin identificarnos. Algunos de estos casos son:

* El propio servicio de login
* El servicio de recuperación de contraseña
* El acceso a páginas con hashlink

Los pasos para crear un nuevo acceso no logueado son los siguientes

### En Quimera:
1. Modificamos *API.js* para incluir las nuevas URLs que no usarán la llamada normal logueada (funcion *urlNeedsLogin*):
    ```js
    const urlNeedsLogin = (url) => {
        const loginUrls = ['login', 'forgot_password', 'check_hashlink']
        const firstWord = url.split('/')[0]
        return !loginUrls.includes(firstWord)
    }
    ```
1. Incluimos el nuevo caso en *Container.ui*:
    ```js
    path && path.startsWith('/forgot-password')
    ? routeResult || <Quimera.View id="PageNotFound" />
    :...
    ```
### En Pineboo API:
1. Incluimos las nuevas rutas en *pinebooapi/motor/YBLOGIN/urls.py*:
    ```py
    path('forgot_password', views.forgot_password, name='forgot_password'),
    path('forgot_password/', views.forgot_password, name='forgot_password'),
    ```
1. Incluimos la llamada a *APIQSA.py* en el fichero *pinebooapi/motor/YBLOGIN/views.py*:
    ```py
    @csrf_exempt
    def forgot_password(request):
        try:
            params = json.loads(request.body.decode("utf-8"))
            username = params["username"]
        except Exception:
            username = request.POST.get("username", None)

        try:
            APIQSA.forgot_password(username)
            result = HttpResponse(json.dumps({}), status=200)

        except Exception as e:
            result = HttpResponse(json.dumps({'error': str(e)}), status=404)
        result['Access-Control-Allow-Origin'] = '*'
        return result
    ```
1. Definimos la función como una llamada a nuestra librería en el fichero *pinebooapi/motor/YBUTILS/APIQSA.py*:
    ```py
    def forgot_password(username):
        try:
            obj = qsa.from_project("formAPI").forgot_password(username)
        except Exception as e:
            print(bcolors.FAIL + "Excepcion " + str(e) + bcolors.ENDC)

            ex_type, ex_value, ex_traceback = sys.exc_info()

            # Extract unformatter stack traces as tuples
            trace_back = traceback.extract_tb(ex_traceback)

            # Format stacktrace
            stack_trace = list()

            for trace in trace_back:
                stack_trace.append("File : %s , Line : %d, Func.Name : %s, Message : %s" % (trace[0], trace[1], trace[2], trace[3]))
            raise Exception(e)
        return obj
    ```
### Más

  * [Volver al Índice](./index.md)
