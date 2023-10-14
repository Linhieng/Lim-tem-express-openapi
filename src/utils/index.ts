// import camelCase from 'camelcase'

// export function formatDate(date: Date): string {
//     return date.toLocaleString()
// }

export function convertToCamelCase(obj: any) {
    if (obj === null || typeof obj !== 'object') {
        return obj
    }

    if (obj instanceof Date) {
        // return formatDate(obj)
        return obj
    }

    if (Array.isArray(obj)) {
        return obj.map((item) => convertToCamelCase(item))
    }

    const camelCaseObj = {}
    for (const key in obj) {
        if (obj.hasOwnProperty(key)) {
            const camelCaseKey = key.replace(/_([a-z])/g, (_, letter) =>
                letter.toUpperCase(),
            )
            // const camelCaseKey = camelCase(key)
            camelCaseObj[camelCaseKey] = convertToCamelCase(obj[key])
        }
    }

    return camelCaseObj
}
