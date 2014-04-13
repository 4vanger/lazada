var heads = require("robohydra").heads;

exports.getBodyParts = function(conf) {
    return {
        heads: [
	        new heads.RoboHydraHeadFilesystem({
                mountPath: '/js',
                documentRoot: 'dist/js/'
            }),
	        new heads.RoboHydraHeadFilesystem({
                mountPath: '/css',
                documentRoot: 'dist/css/'
            }),
	        new heads.RoboHydraHeadProxy({
		        mountPath: '/proxy',
		        proxyTo: 'http://www.lazada.vn',
		        setHostHeader: true
	        }),
	        new heads.RoboHydraHeadFilesystem({
                mountPath: '/',
                documentRoot: 'dist/'
            })
        ]
    };
};
