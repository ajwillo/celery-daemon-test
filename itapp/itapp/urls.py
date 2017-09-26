from django.conf.urls import include, url
from django.conf import settings
from django.contrib.auth import views as auth_views
from django.contrib import admin
import home.views
admin.autodiscover()

from django.conf.urls import (
    handler400, handler403, handler404, handler500
)

handler400 = 'home.views.bad_request'
handler403 = 'home.views.permission_denied'
handler404 = 'home.views.page_not_found'
handler500 = 'home.views.server_error'

urlpatterns = [
    url(r'^', include('home.urls')),
    url('^', include('django.contrib.auth.urls')),    
]
if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        url(r'^__debug__/', include(debug_toolbar.urls)),
    ] + urlpatterns

from django.conf.urls.static import static
urlpatterns += static(settings.MEDIA_URL,
                      document_root=settings.MEDIA_ROOT)

admin.site.site_header = 'IT Application Administration'
